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
pacman-mirrors -g

echo "====================================================================="
echo "======================== updating packages =========================="
echo "====================================================================="
pacman -Syyuu --noconfirm

echo "====================================================================="
echo "========= installing development tools and needed packages =========="
echo "====================================================================="
pacman -S --noconfirm \
  android-tools apache apache-ant asciinema atom bower clang cmake codeblocks \
  command-not-found eclipse-java emacs firefox-i18n-pt-br gcc-docs gdb git \
  gvim htop jdk8-openjdk jre8-openjdk jre8-openjdk-headless kio-gdrive \
  kolourpaint llvm mariadb mariadb-clients moc mtpfs netbeans net-tools nodejs \
  npm openjdk8-doc pgadmin3 php php-mcrypt php-pgsql php-gd pkgfile postgresql \
  psqlodbc python-xdg rhino ruby samba screenfetch sox sshfs tcc tcp_wrappers \
  terminator three.js ttf-anonymous-pro ttf-ubuntu-font-family tmux traceroute \
  valgrind vi vim vim-plugins wget wine wine-mono wine_gecko winetricks xournal \
  youtube-dl xterm zenity

if [ $? != 0 ]; then
    echo ""
    echo "ERROR running pacman -- must check if all packages are available"
    exit 1
fi

echo "====================================================================="
echo "====== installing Node-based APIs (Ionic, Angular, React, ...) ======"
echo "====================================================================="
npm install -g yo
npm install -g generator-angular
npm install -g bower grunt
npm install -g ionic cordova
npm install -g react-native-cli

echo "====================================================================="
echo "=============== removing some unnecessary packages =================="
echo "====================================================================="
pacman -Qdtq | pacman --noconfirm -Rns -
pacman -Sc --noconfirm

echo "====================================================================="
echo "==================== optimizing pacman database ====================="
echo "====================================================================="
pacman-optimize

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
_SILENT_JAVA_OPTIONS="$_JAVA_OPTIONS"
unset _JAVA_OPTIONS
alias java='java "$_SILENT_JAVA_OPTIONS"'
EOF

echo "====================================================================="
echo "============== customizing .bashrc and profile picture =============="
echo "====================================================================="
cp face.png /home/fabsoftware/.face
cp extend.bashrc /home/fabsoftware/.extend.bashrc

echo "====================================================================="
echo "=============== enabling and initializing PostgreSQL ================"
echo "====================================================================="
systemctl enable postgresql.service
su - postgres -c "initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data'"
systemctl restart postgresql.service
