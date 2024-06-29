#!/bin/bash

set -e

# Define variables
APP_NAME="DNSChanger"
EXECUTABLE_NAME="dns_changer"
APP_VERSION="v1.0.0"
GITHUB_REPO="yasdpt/dns-changer"
RELEASE_FILE="DNSChanger-linux-x64-$APP_VERSION.tar.gz"
INSTALL_DIR="/opt/$APP_NAME"
DESKTOP_FILE="/usr/share/applications/$APP_NAME.desktop"
TEMP_DIR="/tmp/$APP_NAME-install"
WRAPPER_SCRIPT="/usr/local/bin/run-$APP_NAME"

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

# Create wrapper script
echo "Creating wrapper script..."
cat > "$WRAPPER_SCRIPT" << EOL
#!/bin/sh
pkexec "/opt/$APP_NAME/$EXECUTABLE_NAME" "$@"
EOL

POLICY_FILE="/usr/share/polkit-1/actions/$APP_NAME.policy"
cat > "$POLICY_FILE" << EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE policyconfig PUBLIC
 "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/PolicyKit/1/policyconfig.dtd">

<policyconfig>

  <action id="org.freedesktop.policykit.pkexec.run-$APP_NAME">
    <description>Run $APP_NAME</description>
    <message>Authentication is required to run $APP_NAME</message>
    <defaults>
      <allow_any>no</allow_any>
      <allow_inactive>no</allow_inactive>
      <allow_active>auth_admin_keep</allow_active>
    </defaults>
    <annotate key="org.freedesktop.policykit.exec.path">/opt/$APP_NAME/$EXECUTABLE_NAME</annotate>
    <annotate key="org.freedesktop.policykit.exec.allow_gui">TRUE</annotate>
  </action>

</policyconfig>
EOL

# Create desktop entry
echo "Creating desktop entry..."
cat > "$DESKTOP_FILE" << EOL
[Desktop Entry]
Name=$APP_NAME
Exec=$WRAPPER_SCRIPT
Icon=$INSTALL_DIR/data/flutter_assets/assets/images/logo.png
Type=Application
Categories=Utility;
EOL

# Set permissions
chmod 755 $WRAPPER_SCRIPT
chmod 755 "$INSTALL_DIR/$EXECUTABLE_NAME"

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
