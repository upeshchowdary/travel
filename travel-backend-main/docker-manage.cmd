@echo off
REM Travel Management System - Docker Management Script
REM Usage: docker-manage.cmd [start|stop|restart|status|logs|clean|build]

setlocal enabledelayedexpansion

if "%1"=="" (
    echo Usage: docker-manage.cmd [command]
    echo.
    echo Commands:
    echo   start      - Start the Docker container
    echo   stop       - Stop the Docker container
    echo   restart    - Restart the Docker container
    echo   status     - Show container status
    echo   logs       - Show container logs
    echo   logs-f     - Show container logs (follow mode)
    echo   clean      - Stop and remove containers and volumes
    echo   build      - Build the Docker image
    echo   shell      - Open shell inside container
    echo   help       - Show this help message
    exit /b 1
)

if "%1"=="start" (
    echo Starting Travel Management System Docker container...
    docker-compose up -d
    echo.
    echo Container started! Access at http://localhost:3000
    exit /b 0
)

if "%1"=="stop" (
    echo Stopping Travel Management System Docker container...
    docker-compose down
    echo Container stopped!
    exit /b 0
)

if "%1"=="restart" (
    echo Restarting Travel Management System Docker container...
    docker-compose restart
    echo Container restarted!
    exit /b 0
)

if "%1"=="status" (
    echo Container Status:
    docker-compose ps
    echo.
    echo Volumes:
    docker volume ls ^| findstr tms
    exit /b 0
)

if "%1"=="logs" (
    echo Showing logs...
    docker-compose logs travelmanagement
    exit /b 0
)

if "%1"=="logs-f" (
    echo Showing logs (follow mode)...
    docker-compose logs -f travelmanagement
    exit /b 0
)

if "%1"=="clean" (
    echo Cleaning up Docker resources...
    docker-compose down -v
    echo.
    echo Cleanup complete! All containers and volumes removed.
    exit /b 0
)

if "%1"=="build" (
    echo Building Docker image...
    docker-compose build --no-cache
    echo Build complete!
    exit /b 0
)

if "%1"=="shell" (
    echo Opening shell inside container...
    docker-compose exec travelmanagement /bin/sh
    exit /b 0
)

if "%1"=="help" (
    echo Usage: docker-manage.cmd [command]
    echo.
    echo Commands:
    echo   start      - Start the Docker container
    echo   stop       - Stop the Docker container
    echo   restart    - Restart the Docker container
    echo   status     - Show container status
    echo   logs       - Show container logs
    echo   logs-f     - Show container logs (follow mode)
    echo   clean      - Stop and remove containers and volumes
    echo   build      - Build the Docker image
    echo   shell      - Open shell inside container
    echo   help       - Show this help message
    exit /b 0
)

echo Unknown command: %1
exit /b 1
