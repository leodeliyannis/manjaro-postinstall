echo "====================================================================="
echo "======= installing packages from AUR (Arch Users Repository) ========"
echo "====================================================================="
yaourt -S --noconfirm --needed \
  android-studio astah-community google-chrome mattercontrol \
  pencil sublime-text-dev ttf-monaco wps-office
if [ $? != 0 ]; then
  echo ""
  echo "ERROR running yaourt -- must check if all packages are available"
  exit 1
fi
