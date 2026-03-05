# ezpublish-legacy-lab
Minimalistic lab to get a eZ Publish legacy kernel running using docker compose :
```bash
docker compose up --build -d
```

## Requirements
- Docker
- Docker Compose

## Services
- **web** : PHP 7.4 + Apache, available at http://localhost:8080
- **db** : MySQL 5.7

## Usage
```bash
# Connect as ezpublish user
docker compose exec web su ezpublish
```

## Notes
- DFS mount point is simulated locally at `/mnt/dfs`
- Settings overrides are in `docker/settings/`
- MySQL test data is initialized from `docker/mysql/init.sql`