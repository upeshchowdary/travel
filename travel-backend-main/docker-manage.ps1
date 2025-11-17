#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Travel Management System - Docker Management Script

.DESCRIPTION
    Provides easy management of the Travel Management System Docker containers

.PARAMETER Command
    The command to execute

.EXAMPLE
    .\docker-manage.ps1 -Command start
#>

param(
    [Parameter(Position = 0)]
    [ValidateSet('start', 'stop', 'restart', 'status', 'logs', 'logs-f', 'clean', 'build', 'shell', 'help')]
    [string]$Command = 'help'
)

$ErrorActionPreference = 'Stop'

function Show-Help {
    Write-Host @"
Travel Management System - Docker Management

Usage: .\docker-manage.ps1 -Command [command]

Commands:
  start      - Start the Docker container
  stop       - Stop the Docker container
  restart    - Restart the Docker container
  status     - Show container status and volumes
  logs       - Show container logs
  logs-f     - Show container logs (follow mode)
  clean      - Stop and remove containers and volumes
  build      - Build the Docker image
  shell      - Open shell inside container
  help       - Show this help message

Examples:
  .\docker-manage.ps1 -Command start
  .\docker-manage.ps1 -Command logs-f
  .\docker-manage.ps1 -Command status
"@
}

function Start-Container {
    Write-Host "Starting Travel Management System Docker container..." -ForegroundColor Green
    docker-compose up -d
    Write-Host "`nContainer started! Access at http://localhost:3000" -ForegroundColor Green
}

function Stop-Container {
    Write-Host "Stopping Travel Management System Docker container..." -ForegroundColor Yellow
    docker-compose down
    Write-Host "Container stopped!" -ForegroundColor Green
}

function Restart-Container {
    Write-Host "Restarting Travel Management System Docker container..." -ForegroundColor Yellow
    docker-compose restart
    Write-Host "Container restarted!" -ForegroundColor Green
}

function Show-Status {
    Write-Host "`n=== Container Status ===" -ForegroundColor Cyan
    docker-compose ps
    
    Write-Host "`n=== Volumes ===" -ForegroundColor Cyan
    docker volume ls | Select-String tms
    
    Write-Host "`n=== Port Mapping ===" -ForegroundColor Cyan
    Write-Host "Frontend: http://localhost:3000" -ForegroundColor Green
}

function Show-Logs {
    Write-Host "Showing logs..." -ForegroundColor Cyan
    docker-compose logs travelmanagement
}

function Show-LogsFollow {
    Write-Host "Showing logs (follow mode - press Ctrl+C to exit)..." -ForegroundColor Cyan
    docker-compose logs -f travelmanagement
}

function Clean-Resources {
    Write-Host "Cleaning up Docker resources..." -ForegroundColor Yellow
    docker-compose down -v
    Write-Host "`nCleanup complete! All containers and volumes removed." -ForegroundColor Green
}

function Build-Image {
    Write-Host "Building Docker image..." -ForegroundColor Green
    docker-compose build --no-cache
    Write-Host "Build complete!" -ForegroundColor Green
}

function Open-Shell {
    Write-Host "Opening shell inside container..." -ForegroundColor Cyan
    docker-compose exec travelmanagement /bin/sh
}

# Execute the command
switch ($Command) {
    'start' { Start-Container }
    'stop' { Stop-Container }
    'restart' { Restart-Container }
    'status' { Show-Status }
    'logs' { Show-Logs }
    'logs-f' { Show-LogsFollow }
    'clean' { Clean-Resources }
    'build' { Build-Image }
    'shell' { Open-Shell }
    'help' { Show-Help }
    default { Show-Help }
}
