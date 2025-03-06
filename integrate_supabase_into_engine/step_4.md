# For community dashboard

We will extend the schema found in `supabase-db` by introducing tables to support building a community dashboard app.

> **ℹ️ Info:**  
> You can use Prisma or the Studio Dashboard to create these tables.

## Members, Transfers and Interactions

### `a_members`
The value of the `id` column will be generated via a 
[trigger function](#id-of-a_members).

```bash
model Members {
  id              String  @id  // ${account}:${profile_contract}
  account         String
  profile_contract String  // primary profile contract address
  username        String  @default("anonymous")
  name            String  @default("Anonymous")
  description     String  @default("this user does not have a profile")
  image           String  @default("https://ipfs.internal.citizenwallet.xyz/QmeuAaXrJBHygzAEHnvw5AKUHfBasuavsX9fU69rdv4mhh")
  image_medium    String  @default("https://ipfs.internal.citizenwallet.xyz/QmeuAaXrJBHygzAEHnvw5AKUHfBasuavsX9fU69rdv4mhh")
  image_small     String  @default("https://ipfs.internal.citizenwallet.xyz/QmeuAaXrJBHygzAEHnvw5AKUHfBasuavsX9fU69rdv4mhh")
  token_id        String?
  created_at      DateTime  @default(now())
  updated_at      DateTime  @default(now())

  sent_transfers        Transfers[]  @relation("FromAccount")
  received_transfers    Transfers[]  @relation("ToAccount")

  interactions_as_first_person  Interactions[]  @relation("FirstPersonInteractions")
  interactions_as_second_person Interactions[]  @relation("SecondPersonInteractions")

  @@map("a_members")
}
```

### `a_transfers`

Records of the `a_transfers` table are inserted by `cw_functions` through the functions `process_tx` and `process_tx_data`, which are invoked by triggers in the `t_logs_100` and `t_logs_data_100` tables, respectively.

The order of these triggers is uncertain; therefore, `from_member_id`, `to_member_id`, and `token_contract` are nullable.
```
model Transfers {
  id             String  @id // hash
  hash           String // tx_hash
  from_member_id String?
  to_member_id   String?
  token_contract String?  // primary token contract address
  value          String  @default("0")
  description    String  @default("")
  status         String  @default("pending")
  created_at     DateTime  @default(now())
  updated_at     DateTime  @default(now())

  from_member    Members?  @relation("FromAccount", fields: [from_member_id], references: [id], onDelete: Cascade)
  to_member      Members?  @relation("ToAccount", fields: [to_member_id], references: [id], onDelete: Cascade)

  interactions   Interactions[]

  @@map("a_transfers")
}
```

### `a_interactions`

To capture the last transfer event between two members, in the perspective of both. For one transfer, two interaction records are created.
```
model Interactions {
  id                        String  @id  @default(uuid())
  transfer_id               String
  first_person_member_id    String
  second_person_member_id   String
  new_interaction           Boolean  @default(false)
  created_at                DateTime  @default(now())
  updated_at                DateTime  @default(now())

  transfer                  Transfers  @relation(fields: [transfer_id], references: [id], onDelete: Cascade)

  first_person_member       Members  @relation("FirstPersonInteractions", fields: [first_person_member_id], references: [id], onDelete: Cascade)
  second_person_member      Members  @relation("SecondPersonInteractions", fields: [second_person_member_id], references: [id], onDelete: Cascade)

  @@unique([transfer_id, first_person_member_id, second_person_member_id])

  @@map("a_interactions")
}
```

Create equivalent SQL migration file:
```
npx prisma migrate dev --create-only --name members_transfers_interactions
```

## Database user `service_role`
Elevate permission on tables in `public` schema.
```sql
--  Grant  usage  on  schema
GRANT  USAGE  ON  SCHEMA  public  TO  service_role;

--  Grant  all  privileges  on  all  tables  in  public  schema
GRANT  ALL  PRIVILEGES  ON  ALL  TABLES  IN  SCHEMA  public  TO  service_role;

--  Grant  all  privileges  on  all  sequences  in  public  schema
GRANT  ALL  PRIVILEGES  ON  ALL  SEQUENCES  IN  SCHEMA  public  TO  service_role;

--  Make  sure  future  tables  grant  the  same  permissions
ALTER  DEFAULT  PRIVILEGES  IN  SCHEMA  public  GRANT  ALL  ON  TABLES  TO  service_role;
ALTER  DEFAULT  PRIVILEGES  IN  SCHEMA  public  GRANT  ALL  ON  SEQUENCES  TO  service_role;
```

## `updated_at` trigger
```sql
-- Create the updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for each table
CREATE TRIGGER update_a_members_updated_at
BEFORE UPDATE ON a_members
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_a_transfers_updated_at
BEFORE UPDATE ON a_transfers
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_a_interactions_updated_at
BEFORE UPDATE ON a_interactions
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();
```

## `id` of `a_members`
```sql
CREATE OR REPLACE FUNCTION generate_member_id()
RETURNS TRIGGER AS $$
BEGIN
  NEW.id = NEW.account || ':' || NEW.profile_contract;
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER assign_member_id
BEFORE INSERT OR UPDATE ON a_members
FOR EACH ROW
EXECUTE FUNCTION generate_member_id();
```

## Triggers in t_logs_100

```sql
--  First,  drop  the  existing  trigger
DROP  TRIGGER  IF  EXISTS  "process-tx"  ON  t_logs_100;

--  Then  recreate  it  with  the  proper  function  name
CREATE  TRIGGER  "process-tx"
AFTER  INSERT  OR  UPDATE  ON  t_logs_100
FOR  EACH  ROW
EXECUTE  PROCEDURE  supabase_functions.http_request('http://kong:8000/functions/v1/process-tx',  'POST');

DROP  TRIGGER  IF  EXISTS "download-profile-data" ON  t_logs_100;

--  Then  recreate  it  with  the  proper  function  name
CREATE  TRIGGER "download-profile-data"
AFTER  INSERT  OR  UPDATE  ON  t_logs_100
FOR  EACH  ROW
EXECUTE  PROCEDURE  supabase_functions.http_request('http://kong:8000/functions/v1/download-profile-data', 'POST');

DROP TRIGGER IF EXISTS "notify-successful-tx" ON t_logs_100;

-- Then recreate it with the proper function name
CREATE TRIGGER "notify-successful-tx"
AFTER INSERT OR UPDATE ON t_logs_100
FOR EACH ROW
EXECUTE PROCEDURE supabase_functions.http_request('http://kong:8000/functions/v1/notify-successful-transaction', 'POST');
```

## Triggers in t_logs_data_100
```sql
DROP TRIGGER IF EXISTS "process-tx-data" ON t_logs_data_100;

-- Then recreate it with the proper function name
CREATE TRIGGER "process-tx-data"
AFTER INSERT OR UPDATE ON t_logs_data_100
FOR EACH ROW
EXECUTE PROCEDURE supabase_functions.http_request('http://kong:8000/functions/v1/process-tx-data', 'POST');
```