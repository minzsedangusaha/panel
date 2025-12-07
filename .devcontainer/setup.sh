#!/bin/bash

echo "🔧 Setting up Pterodactyl in Codespace..."

# Update packages
sudo apt-get update

# Install PHP and dependencies (for artisan commands)
sudo apt-get install -y php8.1 php8.1-curl php8.1-mysql php8.1-mbstring \
  php8.1-gd php8.1-xml php8.1-zip php8.1-bcmath php8.1-fpm

# Install Node.js (for frontend)
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

# Copy environment
cp .env.example .env

# Generate key
php artisan key:generate --force

# Set permissions
sudo chmod -R 755 storage/* bootstrap/cache
sudo chown -R www-data:www-data storage bootstrap/cache

echo "✅ Basic setup complete!"
echo "👉 Run: docker-compose up -d"
