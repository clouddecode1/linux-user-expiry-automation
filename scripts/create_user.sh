#!/bin/bash

set -e

USERNAME=$1
EXPIRY_DATE=$2

if [[ -z "$USERNAME" || -z "$EXPIRY_DATE" ]]; then
  echo "Usage: $0 <username> <expiry_date>"
  exit 1
fi

echo "🚀 Creating user: $USERNAME"
echo "📅 Expiry date: $EXPIRY_DATE"

# Create user
sudo useradd -m -e "$EXPIRY_DATE" "$USERNAME"

# Generate random password
PASSWORD=$(openssl rand -base64 12)
echo "$USERNAME:$PASSWORD" | sudo chpasswd

# Force password change on first login
sudo chage -d 0 "$USERNAME"

# Verify
echo "🔍 Verifying user details..."
sudo chage -l "$USERNAME"

echo "✅ User $USERNAME created successfully"
