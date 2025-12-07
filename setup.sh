#!/bin/bash

echo "📦 Setup Pterodactyl Panel"
echo "=========================="

# 1. Clone repo (jika belum)
if [ ! -d "panel" ]; then
    echo "Cloning repository..."
    git clone https://github.com/USERNAME_ANDA/panel.git
    cd panel
else
    cd panel
    git pull
fi

# 2. Copy environment file
cp .env.example .env

# 3. Run Docker
echo "Starting Docker containers..."
docker-compose up -d

# 4. Setup panel
echo "Setting up panel inside container..."
docker-compose exec panel php artisan key:generate --force
docker-compose exec panel php artisan p:environment:setup
docker-compose exec panel php artisan migrate --seed

# 5. Create admin user
echo "Create admin user:"
docker-compose exec panel php artisan p:user:make

echo "✅ Setup complete!"
echo "🌐 Access panel at: http://localhost"
echo "🔧 Admin user created"
