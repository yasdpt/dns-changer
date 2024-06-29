#!/bin/bash

set -e

# Define variables
APP_NAME="DNSChanger"
GITHUB_REPO="yasdpt/dns-changer"
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

# Fetch the latest release information
echo "Fetching latest release information..."
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$GITHUB_REPO/releases/latest")
DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | jq -r '.assets[] | select(.name | endswith(".zip")) | .browser_download_url')

if [ -z "$DOWNLOAD_URL" ]; then
  echo "Failed to find download URL. Please check the repository and release asset names."
  exit 1
fi

# Download the release
echo "Downloading latest release..."
curl -L -o "${APP_NAME}.zip" "$DOWNLOAD_URL"

# Unzip the download
echo "Extracting files..."
unzip -q "${APP_NAME}.zip"

# Create installation directory
mkdir -p "$INSTALL_DIR"

# Copy application files
echo "Installing application files..."
cp -r * "$INSTALL_DIR"

# Create desktop entry
echo "Creating desktop entry..."
cat > "$DESKTOP_FILE" << EOL
[Desktop Entry]
Name=$APP_NAME
Exec=$INSTALL_DIR/$APP_NAME
Icon=$INSTALL_DIR/data/flutter_assets/assets/app_icon.png
Type=Application
Categories=Utility;
EOL

# Set permissions
chmod +x "$INSTALL_DIR/$APP_NAME"

# Clean up
cd /
rm -rf "$TEMP_DIR"

echo "Installing required dependencies..."
apt-get update && apt-get install libayatana-appindicator3-dev -y


echo "Disabling auto DNS change by other applications..."
systemctl disable --now systemd-resolved.service
rm /etc/resolv.conf

echo '[main]' | tee /etc/NetworkManager/conf.d/no-dns.conf
echo 'dns=none' | tee -a /etc/NetworkManager/conf.d/no-dns.conf
systemctl restart NetworkManager.service

echo "Installation completed. You can now run $APP_NAME from your application menu."
