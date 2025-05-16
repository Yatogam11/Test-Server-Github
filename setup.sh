#!/bin/bash

# setup.sh - Script untuk setup server dasar di Codespace

echo "🔹 Memulai setup server dasar..."

# 1. Update package list
echo "🔹 Mengupdate package list..."
sudo apt-get update

# 2. Install Node.js dan npm
echo "🔹 Menginstall Node.js dan npm..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# 3. Install PM2 (Process Manager)
echo "🔹 Menginstall PM2..."
sudo npm install -g pm2

# 4. Install dependensi proyek
echo "🔹 Menginstall dependensi proyek..."
npm install

# 5. Setup environment variables
echo "🔹 Setup environment variables..."
if [ ! -f .env ]; then
  cat > .env <<EOL
PORT=3000
NODE_ENV=development
DB_HOST=localhost
DB_USER=root
DB_PASS=$(openssl rand -base64 12)
DB_NAME=myapp_dev
EOL
  echo "File .env telah dibuat"
else
  echo "File .env sudah ada, tidak dibuat baru"
fi

# 6. Jalankan server dengan PM2
echo "🔹 Menjalankan server dengan PM2..."
pm2 start server.js --name "basic-server" --watch

# 7. Simpan proses PM2
pm2 save
pm2 startup

# 8. Info ports di Codespace
echo "🔹 Informasi Ports:"
echo "Aplikasi berjalan di port 3000"
echo "Anda bisa mengaksesnya di tab 'Ports' atau dengan mengklik link yang muncul"

echo "✅ Setup selesai! Server berjalan dengan PM2"
