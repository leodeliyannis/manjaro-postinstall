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
echo "==================== optimizing pacman database ====================="
echo "====================================================================="
pacman-optimize

echo "====================================================================="
echo "========= installing development tools and needed packages =========="
echo "====================================================================="
pacman -S --noconfirm android-tools apache apache-ant atom bower clang cmake \
  codeblocks command-not-found eclipse-java emacs gcc-docs gdb git gvim htop \
  jdk8-openjdk jre8-openjdk jre8-openjdk-headless kio-gdrive kolourpaint llvm \
  mariadb mariadb-clients moc mtpfs netbeans net-tools nodejs npm openjdk8-doc \
  pgadmin3 php php-mcrypt php-pgsql php-gd pkgfile postgresql psqlodbc \
  python-xdg rhino ruby samba screenfetch sox sshfs tcc tcp_wrappers \
  ttf-anonymous-pro ttf-ubuntu-font-family tmux traceroute valgrind vi vim \
  vim-plugins wine wine-mono wine_gecko winetricks xournal youtube-dl xterm \
  zenity

if [ $? != 0 ]; then
    echo ""
    echo "ERROR running pacman -- must check if all packages are available"
    exit 1
fi

echo "====================================================================="
echo "================= installing AngularJS and Ionic ===================="
echo "====================================================================="
npm install -g yo
npm install -g generator-angular
npm install -g bower grunt
npm install -g ionic cordova

echo "====================================================================="
echo "============== enabling and initializing PostgreSQL ================="
echo "====================================================================="
systemctl enable postgresql.service
su - postgres -c "initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data'"
systemctl restart postgresql.service

echo "====================================================================="
echo "=============== removing some unnecessary packages =================="
echo "====================================================================="
pacman -Rns steam-manjaro
pacman -Qdtq | pacman -Rs -
pacman -Sc

echo "====================================================================="
echo "================= fixing Java fonts antialiasing ===================="
echo "====================================================================="
cat <<EOF >> /etc/environment
_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
EOF

cat <<EOF >> /etc/bash.bashrc
### Java options
_SILENT_JAVA_OPTIONS="$_JAVA_OPTIONS"
unset _JAVA_OPTIONS
alias java='java "$_SILENT_JAVA_OPTIONS"'
EOF
