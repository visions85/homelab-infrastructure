#!/bin/bash
# Script to manage all Docker services from the main docker-compose.yml
# Part of homelab infrastructure management automation

case "$1" in
    "start")
        echo "Starting all services..."
        docker compose up -d
        ;;
    "stop")
        echo "Stopping all services..."
        docker compose down
        ;;
    "restart")
        echo "Restarting all services..."
        docker compose restart
        ;;
    "status")
        echo "Status of all services..."
        docker compose ps
        ;;
    "logs")
        if [ -n "$2" ]; then
            echo "Showing logs for service: $2"
            docker compose logs -f "$2"
        else
            echo "Showing logs for all services..."
            docker compose logs
        fi
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status|logs [service_name]}"
        echo ""
        echo "This script manages all Docker services across all subdirectories."
        echo "Commands:"
        echo "  start    - Start all services"
        echo "  stop     - Stop all services"
        echo "  restart  - Restart all services"
        echo "  status   - Show status of all services"
        echo "  logs     - Show logs (optionally for specific service)"
        exit 1
        ;;
esac
