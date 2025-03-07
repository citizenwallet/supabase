
# Supabase in VPS  

```bash
# Clone Supabase  
git clone --depth 1 https://github.com/supabase/supabase  

# Navigate to the Docker directory  
cd supabase/docker  
```

## Backup Original Files  

```bash
# Create a copy of the Docker Compose file  
cp docker-compose.yml docker-compose.yml.bkp  

# Create a copy of the example environment variables file  
cp .env.example .env  
```

## Run Supabase Stack  

```bash
# Pull the latest images  
docker compose pull  

# Start the services (in detached mode)  
docker compose up -d  

# Health check  
docker compose ps  

# If any service is not running, start it manually  
docker compose start <service-name>  
```

## Configure `.env`  

### Prerequisite to changing `POSTGRES_PASSWORD`  
Reference: [GitHub Issue](https://github.com/supabase/supabase/issues/22605#issuecomment-2455781878)  

We need to change the database users' passwords before editing the `supabase/docker/.env` file.  

```bash
# Connect to the Docker service 'supabase-db'  
sudo docker exec -it supabase-db /bin/bash  

# Connect to _supabase as supabase_admin  
# Password is in the .env file  
psql -U supabase_admin -d _supabase  

# Replace $new_passwd with the new password  
# Execute the following SQL commands  
ALTER USER anon WITH PASSWORD '$new_passwd';  
ALTER USER authenticated WITH PASSWORD '$new_passwd';  
ALTER USER authenticator WITH PASSWORD '$new_passwd';  
ALTER USER dashboard_user WITH PASSWORD '$new_passwd';  
ALTER USER pgbouncer WITH PASSWORD '$new_passwd';  
ALTER USER pgsodium_keyholder WITH PASSWORD '$new_passwd';  
ALTER USER pgsodium_keyiduser WITH PASSWORD '$new_passwd';  
ALTER USER pgsodium_keymaker WITH PASSWORD '$new_passwd';  
ALTER USER postgres WITH PASSWORD '$new_passwd';  
ALTER USER service_role WITH PASSWORD '$new_passwd';  
ALTER USER supabase_admin WITH PASSWORD '$new_passwd';  
ALTER USER supabase_auth_admin WITH PASSWORD '$new_passwd';  
ALTER USER supabase_functions_admin WITH PASSWORD '$new_passwd';  
ALTER USER supabase_read_only_user WITH PASSWORD '$new_passwd';  
ALTER USER supabase_replication_admin WITH PASSWORD '$new_passwd';  
ALTER USER supabase_storage_admin WITH PASSWORD '$new_passwd';  

# Replace $new_passwd with the new password  
# Execute the following SQL command  
UPDATE _analytics.source_backends  
SET config = jsonb_set(config, '{url}', '"postgresql://supabase_admin:$new_passwd@db:5432/postgres"', 'false')  
WHERE type='postgres';  
```

Shutdown the Supabase stack:  

```bash
docker compose down  
```

Now we can edit the file `supabase/docker/.env`.  

> **ℹ️ Tip:**  
> Use [Self-Hosting with Docker | Supabase Docs](https://supabase.com/docs/guides/self-hosting/docker#generate-api-keys) to generate `JWT_SECRET`, `ANON_KEY`, and `SERVICE_ROLE_KEY`.  
>  
> `POSTGRES_PASSWORD` is `$new_passwd` from [here](#prerequisite-to-change-postgres_password).  
>  
> Use the root domain name for `SITE_URL`, `API_EXTERNAL_URL`, and `SUPABASE_PUBLIC_URL` for easier setup.  

```bash
POSTGRES_PASSWORD=  
JWT_SECRET=  
ANON_KEY=  
SERVICE_ROLE_KEY=  

# Supabase Studio  
DASHBOARD_USERNAME=  
DASHBOARD_PASSWORD=  

POOLER_TENANT_ID=postgres  

SITE_URL=  
API_EXTERNAL_URL=  

# Supabase Studio  
STUDIO_DEFAULT_ORGANIZATION=  
STUDIO_DEFAULT_PROJECT=  
SUPABASE_PUBLIC_URL=  
```

### Using `cw_functions` (Optional)  

In the home directory of the VPS, clone [citizenwallet/supabase](https://github.com/citizenwallet/supabase). The cloned directory will be called `cw_supabase`.  

```bash
git clone https://github.com/citizenwallet/supabase.git cw_supabase  
```

Create a symlink from `cw_supabase/supabase/functions` to `supabase/docker/volumes`.  

```bash
cd /home/cw/supabase/docker/volumes \
&& ln -s /home/cw/cw_supabase/supabase/functions cw_functions  
```

The name of the symlink is `cw_functions`. You will see the directory `supabase/docker/volumes/cw_functions`.  

#### Add to `supabase/docker/.env`  

```bash
CHAIN_ID=  
IPFS_URL=  
DEFAULT_PROFILE_IMAGE_IPFS_HASH=  
COMMUNITIES_CONFIG_URL=  
```

#### Modify `supabase/docker/docker-compose.yml`  

> **ℹ️ Info:**  
> We are commenting out the default `functions` volume of Supabase.  

```yaml
services:  
  functions:  
    container_name: supabase-edge-functions  
    volumes:  
      # - ./volumes/functions:/home/deno/functions:Z  
      - ./volumes/cw_functions:/home/deno/functions:Z  
    environment:  
      COMMUNITIES_CONFIG_URL: ${COMMUNITIES_CONFIG_URL}  
      CHAIN_ID: ${CHAIN_ID}  
      IPFS_URL: ${IPFS_URL}  
      DEFAULT_PROFILE_IMAGE_IPFS_HASH: ${DEFAULT_PROFILE_IMAGE_IPFS_HASH}  
```

#### Run the Supabase Stack  

```bash
docker compose up -d  
```
