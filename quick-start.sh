#!/bin/bash

# Gas Price Intel - One-Click Setup Script
# This script will clone the repo and start the entire application

set -e

echo "🚀 Gas Price Intelligence Platform - Quick Start"
echo "================================================"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker Desktop first:"
    echo "   https://www.docker.com/products/docker-desktop"
    exit 1
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "❌ Docker is not running. Please start Docker Desktop and try again."
    exit 1
fi

echo "✅ Docker is installed and running"
echo ""

# Clone repository if not already in the directory
if [ ! -f "docker-compose.yml" ]; then
    echo "📥 Cloning repository..."
    cd ~/Desktop
    if [ -d "gas-price-intel" ]; then
        echo "Directory exists, using existing clone..."
        cd gas-price-intel
        git pull
    else
        git clone https://github.com/ramji3030/gas-price-intel.git
        cd gas-price-intel
    fi
fi

echo "✅ Repository ready"
echo ""

# Setup environment file
if [ ! -f ".env" ]; then
    echo "⚙️  Setting up environment configuration..."
    cp .env.example .env
    echo "✅ Environment file created"
fi

echo ""
echo "🐳 Building and starting Docker containers..."
echo "   This may take a few minutes on first run..."
echo ""

# Build and start services
docker-compose down 2>/dev/null || true
docker-compose up --build -d

echo ""
echo "⏳ Waiting for services to be ready..."
sleep 10

echo ""
echo "✅ Setup complete!"
echo ""
echo "🎉 Your Gas Price Intelligence Platform is now running!"
echo ""
echo "Access your application:"
echo "  📊 Frontend Dashboard: http://localhost:3000"
echo "  🔧 Backend API: http://localhost:8000"
echo "  📚 API Documentation: http://localhost:8000/docs"
echo ""
echo "To stop the application: docker-compose down"
echo "To view logs: docker-compose logs -f"
echo ""
echo "Opening browser..."
sleep 2
open http://localhost:3000 || xdg-open http://localhost:3000 || echo "Please open http://localhost:3000 in your browser"
