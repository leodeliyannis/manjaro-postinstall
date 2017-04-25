echo "====================================================================="
echo "======= installing packages from AUR (Arch Users Repository) ========"
echo "====================================================================="
yaourt -S --noconfirm android-studio astah-community google-chrome \
  pepper-flash sublime-text-dev ttf-mac-fonts ttf-monaco ttf-ms-fonts
if [ $? != 0 ]; then
  echo ""
  echo "ERROR running yaourt -- must check if all packages are available"
  exit 1
fi
