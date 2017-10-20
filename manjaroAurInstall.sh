echo "====================================================================="
echo "======= installing packages from AUR (Arch Users Repository) ========"
echo "====================================================================="
yaourt -S --noconfirm --needed \
  android-studio astah-community freshplayerplugin google-chrome pencil \
  sublime-text-dev ttf-monaco wps-office xmind
if [ $? != 0 ]; then
  echo ""
  echo "ERROR running yaourt -- must check if all packages are available"
  exit 1
fi
