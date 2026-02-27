#!/bin/bash
set -e

cd /var/www/html

# Fix ownership Git
git config --global --add safe.directory /var/www/html

# Fix permissions
chown -R ezpublish:www-data /var/www/html
chmod -R 755 /var/www/html
mkdir -p var/log var/cache var/storage /mnt/dfs
chown -R ezpublish:www-data var/ /mnt/dfs

# Installer les dépendances Composer si vendor absent
if [ ! -d "vendor" ]; then
    echo "Installation des dépendances Composer..."
    composer config audit.block-insecure false
    sudo -u ezpublish composer install --no-dev --ignore-platform-reqs 2>&1
fi

# Régénérer l'autoload si absent
if [ ! -f "var/autoload/ezp_extension.php" ]; then
    echo "Génération de l'autoload..."
    sudo -u ezpublish php bin/php/ezpgenerateautoloads.php -v 2>&1
fi

exec "$@"

