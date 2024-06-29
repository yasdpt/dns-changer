#!/bin/bash

set -e

# Define variables
APP_NAME="DNSChanger"
APP_VERSION="v1.0.0"
GITHUB_REPO="yasdpt/dns-changer"
RELEASE_FILE="DNSChanger-linux-x64-$APP_VERSION.tar.gz"
INSTALL_DIR="/opt/$APP_NAME"
DESKTOP_FILE="/usr/share/applications/$APP_NAME.desktop"
TEMP_DIR="/tmp/$APP_NAME-install"

# Check if running with sudo/root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo."
  exit 1
fi

# Check for required tools
for tool in curl jq unzip; do
  if ! command -v $tool &> /dev/null; then
    echo "$tool is required but not installed. Please install it and try again."
    exit 1
  fi
done

# Create temporary directory
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# Construct the download URL
DOWNLOAD_URL="https://github.com/$GITHUB_REPO/releases/download/$APP_VERSION/$RELEASE_FILE"

echo "Download URL: $DOWNLOAD_URL"

# Download the release
echo "Downloading release..."
if curl -L -o "$RELEASE_FILE" "$DOWNLOAD_URL"; then
    echo "Download successful."
else
    echo "Error: Failed to download the release file. Please check the URL and your internet connection."
    exit 1
fi

echo "Extracting files..."
if tar -xzf "$RELEASE_FILE"; then
    echo "Extraction successful."
else
    echo "Error: Failed to extract the release file. The file may be corrupted or not a valid tar.gz archive."
    exit 1
fi

# Create installation directory
mkdir -p "$INSTALL_DIR"

rm $RELEASE_FILE

# Copy application files
echo "Installing application files..."
cp -r * "$INSTALL_DIR"

# Create desktop entry
echo "Creating desktop entry..."
cat > "$DESKTOP_FILE" << EOL
[Desktop Entry]
Name=$APP_NAME
Exec=$INSTALL_DIR/dns_changer
Icon=$INSTALL_DIR/data/flutter_assets/assets/images/logo.png
Type=Application
Categories=Utility;
EOL

# Set permissions
chmod +x "$INSTALL_DIR/dns_changer"

# Clean up
cd /
rm -rf "$TEMP_DIR"

echo "Installing required dependencies..."
apt-get update && apt-get install libayatana-appindicator3-dev -y


echo "Disabling auto DNS change by other applications..."
systemctl disable --now systemd-resolved.service
rm /etc/resolv.conf
echo 'nameserver 8.8.8.8' | tee /etc/resolv.conf > /dev/null
echo 'nameserver 8.8.4.4' | tee -a /etc/resolv.conf > /dev/null

echo '[main]' | tee /etc/NetworkManager/conf.d/no-dns.conf > /dev/null
echo 'dns=none' | tee -a /etc/NetworkManager/conf.d/no-dns.conf > /dev/null
systemctl restart NetworkManager.service

echo "Installation completed. You can now run $APP_NAME from your application menu."
