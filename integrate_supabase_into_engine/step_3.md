
# Bridge `ENGINE` and Supabase  
We will use the `supabase_default` Docker bridge network to link together the services of `ENGINE` and Supabase.  

Open `engine/docker-compose.yml`.  

> **ℹ️ Info:**  
> Use the code snippet at `code_snippets/engine.docker-compose.yml`.  

We will create a copy of the `engine` service and call it `engine_supabase`. The `engine_supabase` service is connected to both the `engine-net` and `supabase_default` networks.  
Additionally, we will connect the `server` service to the `supabase_default` network.  

```yaml
version: '3.8'

services:
  engine_supabase:
    container_name: engine_supabase
    build:
      context: .
      dockerfile: ./.docker/engine/Dockerfile
    networks:
      engine-net:
        aliases:
          - engine-supabase
      supabase_default:
        aliases:
          - engine-supabase
    ports:
      - "3001:3001"
    restart: on-failure
    healthcheck:
      test: "exit 0"

  server:
    image: nginx:latest
    ports:
      - "80:80"
      - "443:443"
    restart: always
    volumes:
      - ./.engine/nginx/conf/:/etc/nginx/conf.d/:ro
      - certs_www_volume:/var/www/certbot/:ro
      - certs_conf_volume:/etc/nginx/ssl/:ro
    networks:
      engine-net:
        aliases:
          - engine-server
      supabase_default:
        aliases:
          - engine-server

networks:
  engine-net:
    name: engine-net
  supabase_default:
    external: true
```

## Connect `ENGINE` to `supabase-db`  
These are the default values from `supabase/docker/.env`:  

```bash
DB_USER=postgres
DB_PASSWORD=
DB_NAME=postgres
DB_PORT=5432
DB_HOST=supabase-db
DB_READER_HOST=supabase-db
```

## Reverse Proxy  
We will update the reverse proxy found at `engine/.engine/nginx/conf/nginx.conf` to serve requests to both `ENGINE` and Supabase.  

> **ℹ️ Info:**  
> Use the code snippet at `code_snippets/engine.nginx.conf`.  

Requests to the following routes will be forwarded to the `ENGINE` application:  
- `/indexer/*`  
- `/health`  
- `/v1/*`  
- `/version`  

All other requests will be forwarded to Supabase.  

## Run `ENGINE`  
```bash
docker compose up -d --build engine_supabase server
```

## Checkpoint  

### Docker Networks  
```bash
docker network ls  
```
#### Expected Output:  
```
NETWORK ID     NAME                DRIVER    SCOPE
8edd8639ddaa   engine-net          bridge    local
3d2168fe33a1   supabase_default    bridge    local
```

### Services in `engine-net`  
```bash
docker network inspect engine-net -f '{{range .Containers}}{{.Name}} ({{.IPv4Address}}){{println}}{{end}}'
```
#### Expected Output:  
```
engine-server-1 (172.19.0.2/16)
engine_supabase (172.19.0.3/16)
```

### Services in `supabase_default`  
```bash
docker network inspect supabase_default -f '{{range .Containers}}{{.Name}} ({{.IPv4Address}}){{println}}{{end}}'
```
#### Expected Output:  
```
supabase-db (172.18.0.4/16)
supabase-kong (172.18.0.13/16)
supabase-rest (172.18.0.6/16)
realtime-dev.supabase-realtime (172.18.0.11/16)
supabase-analytics (172.18.0.5/16)
supabase-storage (172.18.0.14/16)
supabase-studio (172.18.0.9/16)
supabase-imgproxy (172.18.0.2/16)
supabase-pooler (172.18.0.7/16)
supabase-meta (172.18.0.8/16)
supabase-auth (172.18.0.10/16)
supabase-vector (172.18.0.3/16)
supabase-edge-functions (172.18.0.12/16)

engine-server-1 (172.18.0.16/16)
engine_supabase (172.18.0.15/16)
```

### Access to Supabase Studio
Visit your domain to access the Supabase Studio.
Use `DASHBOARD_USERNAME` and `DASHBOARD_PASSWORD` from `supabase/docker/.env` to sign-in.
