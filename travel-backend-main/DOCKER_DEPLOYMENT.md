# Travel Management System Backend - Docker Deployment Guide

## Prerequisites
- Docker installed and running
- Docker Compose installed
- Port 3000 available on your host machine

## Quick Start

### 1. Build and Deploy the Container

```bash
cd travel-backend-main
docker-compose up -d
```

This command will:
- Build the Docker image from the Dockerfile
- Create volumes for logs and data persistence
- Start the container on port 3000
- Set up health checks

### 2. Verify the Deployment

Check if the container is running:
```bash
docker-compose ps
```

Check the logs:
```bash
docker-compose logs -f travelmanagement
```

Test the API:
```bash
curl http://localhost:3000/actuator/health
```

## Available Volumes

The deployment uses two Docker volumes for data persistence:

### 1. `tms-logs`
- **Purpose**: Stores application logs
- **Mount Path**: `/app/logs`
- **Usage**: Logs are persisted across container restarts

### 2. `tms-data`
- **Purpose**: Stores application data
- **Mount Path**: `/app/data`
- **Usage**: Data persists across container restarts

## API Endpoints

Once deployed, the following endpoints are available:

### Authentication
- **POST** `http://localhost:3000/auth/signup` - Register new user
  ```json
  {
    "username": "john_doe",
    "email": "john@example.com",
    "password": "securePassword123"
  }
  ```

- **POST** `http://localhost:3000/auth/login` - Login user
  ```json
  {
    "username": "john_doe",
    "password": "securePassword123"
  }
  ```

### Database Console
- **GET** `http://localhost:3000/h2-console` - H2 Database Console (Development only)

### Health Check
- **GET** `http://localhost:3000/actuator/health` - Application health status

## Managing the Container

### Stop the Container
```bash
docker-compose down
```

### Stop and Remove Volumes
```bash
docker-compose down -v
```

### View Logs
```bash
docker-compose logs travelmanagement
```

### View Recent Logs (Follow Mode)
```bash
docker-compose logs -f travelmanagement
```

### Execute Commands Inside Container
```bash
docker-compose exec travelmanagement /bin/sh
```

### Restart the Container
```bash
docker-compose restart
```

## Volume Management

### View Volumes
```bash
docker volume ls | grep tms
```

### Inspect Volume
```bash
docker volume inspect travel-backend-main_tms-logs
```

### Backup Volume Data
```bash
docker run --rm -v travel-backend-main_tms-logs:/data -v C:\Backup:/backup alpine tar czf /backup/tms-logs-backup.tar.gz -C /data .
```

### Restore Volume Data
```bash
docker run --rm -v travel-backend-main_tms-logs:/data -v C:\Backup:/backup alpine tar xzf /backup/tms-logs-backup.tar.gz -C /data
```

## Configuration

### Environment Variables
You can modify the following environment variables in `docker-compose.yml`:

- `JAVA_OPTS`: JVM options (default: `-Xmx512m -Xms256m`)
- `SERVER_PORT`: Application port (default: `3000`)
- `SPRING_DATASOURCE_URL`: Database URL
- `SPRING_JPA_HIBERNATE_DDL_AUTO`: Hibernate DDL behavior (default: `create-drop`)

### Port Mapping
To change the host port, modify the `ports` section in `docker-compose.yml`:
```yaml
ports:
  - "8080:3000"  # Host:Container port
```

## Troubleshooting

### Port Already in Use
If port 3000 is already in use, change it in `docker-compose.yml`:
```yaml
ports:
  - "8081:3000"  # Use port 8081 instead
```

### Container Exits Immediately
Check the logs:
```bash
docker-compose logs travelmanagement
```

### Volume Permission Issues
Ensure Docker has proper permissions on the volume mount paths.

### Database Connection Issues
Verify the database configuration in `docker-compose.yml` matches your setup.

## Production Deployment Notes

For production deployment, consider:

1. **Use persistent database** (MySQL, PostgreSQL) instead of H2
2. **Add authentication** to the H2 console
3. **Set proper resource limits** in docker-compose.yml
4. **Implement proper logging** to external systems
5. **Use secrets management** for sensitive data
6. **Add reverse proxy** (Nginx) for SSL/TLS
7. **Enable HTTPS** with valid certificates
8. **Set up monitoring and alerting**
9. **Use Docker network** for service isolation
10. **Regular backups** of volumes

## Example Production docker-compose.yml

See the `docker-compose.prod.yml` file for production configuration with MySQL database.

## Support

For issues or questions about the Docker deployment, refer to:
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- Spring Boot Docker [Guide](https://spring.io/guides/gs/spring-boot-docker/)
