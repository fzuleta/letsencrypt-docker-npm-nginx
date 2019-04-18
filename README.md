# 5 steps for a Private NPM registry with Docker, Verdaccio and Let's Encrypt SSL

Make sure you have a domain(or subdomain) and SSH access to an instance. This works well under a DigitalOcean's Ubuntu with Docker and Docker Compose installed.

## Steps (run as root)
1. Set in **docker-compose.yml**, **ssl_gen.sh** and **./verdaccio/conf/conf.yaml** the **DOMAIN=domain.com** to your domain.
2. Delete all **DELETE_ME.yml** files in `certs`, `certs-data`, `data`, `verdaccio/storage` (keep folders).
    ```
    rm certs/DELETE_ME.yml && rm certs-data/DELETE_ME.yml && rm data/DELETE_ME.yml && rm verdaccio/storage/DELETE_ME.yml
    ```
4. `docker-compose up -d`
5. `chmod +x *.sh && ./ssl_gen.sh`  
6. After it succeeds, start it with `docker-compose restart`

You should be able to access the registry via

    - npm: https://domain.com:4873 
    - docker: https://domain.com/

# htpasswd for adding users to registry
Verdaccio uses htpasswd for user management
1. http://www.htaccesstools.com/htpasswd-generator/
2. copy the output to the file `./verdaccio/conf/htpasswd`
3. npm login --registry http://domain.com/npm

# Automatic cron setup ssl renewal

This will schedule a renewal of the SSL cert with Let's Encrypt every 15 days.
1. `crontab -u $USER -e`
2. `0 0 */15 * *  /path/to/registry_files/ssl_renew.sh`

# Notes and Gotchas
- Is there a DNS **A** record pointing to the server?
- Are you using registry.com? (use your own)
- If let's encrypt fails, delete all certs and certs-data files and try again.

### Disclaimer
- In order for the container to write to the host's filesystem, The verdaccio.dockerfile run as `root` (mainly for persisting `storage` folder.
- No warranties, provided as is.

## Need to install Docker in your VPS machine?
https://docs.docker.com/install/linux/docker-ce/ubuntu/

https://docs.docker.com/compose/install/

### Be sure to donate to **letsencrypt.org**!
