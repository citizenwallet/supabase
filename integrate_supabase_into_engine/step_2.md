# Data and Schema

Currently, the `ENGINE` application uses a Postgres Docker image for its database (`engine-db`) requirements.

We will create a copy of the data and schema from `engine-db` so we can restore it to `supabase-db` later.
  
## Create a Copy of Data

> ✅ **Check**

> - Stop the Supabase stack if it is active. `docker compose down`

> - Run the database service `ENGINE` application if it is inactive. `docker compose up -d --build db`

  

We will connect to `engine-db` to get a copy of its data.

```bash

docker exec -it db pg_dump -U <db_user> -d <db_name> --data-only > ~/engine/data.sql
```

  

## Baseline Schema

We will use Prisma ORM to baseline the existing schema in the `ENGINE` application.

  

```bash

# Create a directory for an NPM project

mkdir  ./engine_db  &&  cd  ./engine_db

  

# Initialize a Node.js project

npm  init  -y

  

# Install dependencies

npm  install  prisma  typescript  tsx  @types/node  --save-dev

  

# Initialize TypeScript

npx  tsc  --init

  

# Initialize Prisma project

npx  prisma  init

```

  

### Configure Database Connection

In the `.env` file, create the database connection string for `engine-db`:

  

```bash

DB_USER=

DB_PASSWORD=

DB_HOST=

DB_PORT=

DB_NAME=

DB_SCHEMA=

  

DATABASE_URL="postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}?schema=${DB_SCHEMA}"

```

  

### Pull Schema from `engine-db`

```bash

npx  prisma  db  pull

```

  

### Create Migration File for Baseline

```bash

mkdir  -p  prisma/migrations/0_init

  

# Generate SQL migration file

npx  prisma  migrate  diff  --from-empty  --to-schema-datamodel  prisma/schema.prisma  --script  >  prisma/migrations/0_init/migration.sql

```

  

## Apply Migration to `supabase-db`

> ✅ **Check**

> - Run the Supabase stack if it is inactive.

> - Stop the `ENGINE` application if it is active.

  

In the `.env` file, create the database connection string for `supabase-db`:

  

```bash

DB_USER="postgres.postgres"

DB_PASSWORD=

DB_HOST="localhost"

DB_PORT="5432"

DB_NAME="postgres"

DB_SCHEMA="public"

  

DATABASE_URL="postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}?schema=${DB_SCHEMA}"

```

  

### Apply Schema to `supabase-db`

```bash

npx  prisma  migrate  reset

```

  

### Verify from `supabase-db`

```bash

# Connect to the supabase-db service

docker  exec  -it  supabase-db  psql  -U  postgres

  

# Print tables

\dt

```

  

### Insert Data into `supabase-db`

```bash
# First, copy the file into the container
docker compose cp /home/cw/engine/data.sql db:/tmp/data.sql

# Then restore from within the container
docker compose exec db psql -U postgres -d postgres -f /tmp/data.sql
```