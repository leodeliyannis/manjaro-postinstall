#!/bin/bash
echo "######################################################"
echo "### $0 by constantin.leo@gmail.com ###"
echo "######################################################"

if [ "`id -u`" != "0" ]; then
    echo "Must be run as root"
    exit 1
fi

echo "====================================================================="
echo "======================== updating mirrors ==========================="
echo "====================================================================="
pacman-mirrors -g &&

echo "====================================================================="
echo "======================== updating packages =========================="
echo "====================================================================="
pacman -Syyuu --noconfirm &&

echo "====================================================================="
echo "========= installing development tools and needed packages =========="
echo "====================================================================="
pacman -S --noconfirm --needed \
  android-tools apache apache-ant arduino arduino-avr-core asciinema atom \
  clang cmake codeblocks eclipse-jee emacs firefox-kde-i18n-pt-br freecad \
  gcc-docs gdb git gvim htop jdk8-openjdk jre8-openjdk jre8-openjdk-headless \
  kio-gdrive kolourpaint linux49-headers linux49-virtualbox-host-modules \
  llvm mariadb mariadb-clients moc mtpfs netbeans net-tools nodejs npm \
  openjdk8-doc pepper-flash pgadmin3 php php-mcrypt php-pgsql php-gd pkgfile \
  postgresql psqlodbc python-xdg rhino ruby samba screenfetch sox sshfs tcc \
  tcp_wrappers terminator three.js thunderbird-kde ttf-anonymous-pro \
  ttf-ubuntu-font-family tmux traceroute valgrind vi vim-plugins virtualbox \
  virtualbox-guest-iso virtualbox-host-dkms wget wine wine-mono wine_gecko \
  winetricks xournal youtube-dl xterm zenity

if [ $? != 0 ]; then
    echo ""
    echo "ERROR running pacman -- must check if all packages are available"
    exit 1
fi

echo "====================================================================="
echo "====== installing Node-based APIs (Ionic, Angular, React, ...) ======"
echo "====================================================================="
npm install -g yo generator-angular bower grunt ionic cordova react-native-cli &&

echo "====================================================================="
echo "=============== removing some unnecessary packages =================="
echo "====================================================================="
pacman -Qdtq | pacman --noconfirm -Rns - &&
pacman -Sc --noconfirm &&

echo "====================================================================="
echo "==================== optimizing pacman database ====================="
echo "====================================================================="
pacman-optimize &&

echo "====================================================================="
echo "================= fixing Java fonts antialiasing ===================="
echo "====================================================================="
cat <<EOF >> /etc/environment

### Java fonts antialiasing settings
_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true \
  -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel \
  -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
JAVA_FONTS=/usr/share/fonts/TTF

EOF


cat <<EOF >> /etc/bash.bashrc

### Java options
_SILENT_JAVA_OPTIONS="\$_JAVA_OPTIONS"
unset _JAVA_OPTIONS
alias java='java "\$_SILENT_JAVA_OPTIONS"'

EOF


echo "====================================================================="
echo "============== customizing .bashrc and profile picture =============="
echo "====================================================================="
cp face.png /home/$USER/.face &&
cp extend.bashrc /home/$USER/.extend.bashrc &&

echo "====================================================================="
echo "=============== enabling and initializing PostgreSQL ================"
echo "====================================================================="
systemctl enable postgresql.service &&
su - postgres -c "initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data'" &&
systemctl restart postgresql.service &&

echo "====================================================================="
echo "====================== loading module vboxdrv ======================="
echo "====================================================================="
modprobe vboxdrv

echo "====================================================================="
echo "=============== Installation completed successfully! ================"
echo "====================================================================="
