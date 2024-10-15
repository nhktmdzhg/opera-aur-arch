#!/bin/bash

# Fetch the latest version
latest_version=$(curl -s https://get.geo.opera.com/ftp/pub/opera/desktop/ | grep -Po 'href="\K[0-9.]+' | sort -V | tail -1)
echo "Latest Opera Version: ${latest_version}"

# Check if the version URL is valid
url="https://get.geo.opera.com/ftp/pub/opera/desktop/${latest_version}/linux/opera-stable_${latest_version}_amd64.deb"
response=$(wget --spider -S "$url" 2>&1 | grep "HTTP/" | awk '{print $2}')

if [ "$response" -eq 404 ]; then
  echo "The URL for version ${latest_version} (${url}) returned a 404 error. Aborting update."
  exit 1
else
  echo "The URL for version ${latest_version} is valid."
fi

# Get the currently installed version of Opera
current_version=$(opera --version 2>/dev/null)

# Compare with the latest version
if [[ "$current_version" != *"${latest_version}"* ]]; then
  echo -e "\e[31mUpdate available: The current version ${current_version} is not the latest. Please update to ${latest_version}.\e[0m"
  read -p "Do you want to update Opera now? (y/n) " reply
  echo
  if [[ ! "$reply" =~ ^[Yy]$ ]]; then
    echo "Aborting update."
    exit 1
  fi
  echo "Updating PKGBUILD and .srcinfo with the new version..."

  # Update PKGBUILD and .srcinfo
  curr_folder=$(pwd)
  cd ~/Documents/opera-arch/opera-aur-arch
  cp ./PKGBUILD ./PKGBUILD.bak
  sed -i "s/^pkgver=.*$/pkgver=${latest_version}/" ./PKGBUILD
  makepkg --printsrcinfo > .SRCINFO

  echo "Edit the PKGBUILD file successfully."
  echo "Now we update this package."
  pikaur -Pi
  echo "Update successfully, so PEAK!"
  cd "$curr_folder" || exit 1
else
  echo "The Opera version is up-to-date (${current_version}). No update needed."
fi
