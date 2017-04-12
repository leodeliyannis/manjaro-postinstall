echo "#############################################################################"
echo "### $0 by constantin.leo@gmail.com for KDE neon / Kubuntu ###"
echo "#############################################################################"

if [ "`id -u`" != "0" ]; then
  echo "Must be run as root"
  exit 1
fi

apt-get -y install python-software-properties 2>/dev/null

for i in id chown chmod cut awk tail grep cat sed mkdir rm mv sleep apt-get add-apt-repository update-alternatives; do
  p=`which $i`
  if [ -x "$p" ]; then
    echo -n ""
  else
    echo command "$i" not found
    exit 1
  fi
done
sleep 2

echo "$0" | grep -q "upfParqueInstall.*sh"
if [ $? != 0 ]; then
  echo "Make the install script executable (using chmod) and run it directly, like ./upfParqueInstall.sh"
else  

if [ "$1" != "alreadydone" ]; then
  echo "It is recommended that you run the commands"
  echo "  apt-get update; apt-get upgrade"
  echo "by your own before running this script. If you have already done it,"
  echo "please run the script as"
  echo "   ./install.sh alreadydone"
  exit 1
fi

if [ ! -r /etc/lsb-release ]; then
  echo "File /etc/lsb-release not found. Is this a ubuntu or debian-like distro?"
  exit 1
fi
. /etc/lsb-release

echo "=============================================================="
echo "============== CHECKING FOR OTHER APT SERVERS  ==============="
echo "=============================================================="
echo "============== CHECKING FOR canonical.com APT SERVER  ========"
cd 
grep -q "^[^\#]*deb http://archive.canonical.com.* $DISTRIB_CODENAME .*partner" /etc/apt/sources.list
if [ $? != 0 ]; then
  add-apt-repository "deb http://archive.canonical.com/ubuntu $DISTRIB_CODENAME partner"
fi
dpkg --add-architecture i386
apt-add-repository -y ppa:webupd8team/sublime-text-3
apt-add-repository -y ppa:webupd8team/atom
apt-add-repository -y ppa:paolorotolo/android-studio

apt-get -y update
apt-get -y upgrade

libCppdev=`apt-cache search libstdc++ | grep "libstdc++6-.*-dev " | sort | tail -n1 | cut -d' ' -f1`
if [ "$libCppdev" == "" ]; then
  echo "libstdc++6-*-dev not found"
  exit 1
fi
libCppdbg=`apt-cache search libstdc++ | grep "libstdc++6-.*-dbg " | sort | tail -n1 | cut -d' ' -f1`
if [ "$libCppdbg" == "" ]; then
  echo "libstdc++6-*-dbg not found"
  exit 1
fi
libCppdoc=`apt-cache search libstdc++ | grep "libstdc++6-.*-doc " | sort | tail -n1 | cut -d' ' -f1`
if [ "$libCppdoc" == "" ]; then
  echo "libstdc++6-*-doc not found"
  exit 1
fi

echo "====================================================================="
echo "================= installing packages for UPF Parque ================"
echo "====================================================================="

apt-get -y install zenity apache2 eclipse-pde eclipse-rcp eclipse-platform eclipse-jdt eclipse-cdt eclipse emacs \
  g++ gcc libstdc++6 makepasswd manpages-dev openjdk-8-dbg openjdk-8-jdk \
  mysql-server mysql-client pgadmin3 php-cli php-mcrypt php php-pgsql php-gd \
  postgresql postgresql-client postgresql-contrib default-jdk openjdk-8-doc \
  vim-gnome geany geany-plugin-addons geany-plugins geany-plugin-debugger default-jre \
  vim "$libCppdev" "$libCppdoc" "$libCppdbg" stl-manual gcc-doc c++-annotations \
  libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 \
  libxss1 libappindicator1 libindicator7 fonts-liberation kio-gdrive \
  android-studio atom htop netbeans nodejs npm sublime-text-installer terminator \
  libreoffice libreoffice-kde kate skanlite 
## quota sharutils sysstat debootstrap schroot
  
if [ $? != 0 ]; then
  echo ""
  echo "ERROR running the apt-get -- must check if all needed packages are available"
  exit 1
fi

echo "====================================================================="
echo "=========== installing Google Chrome and Astah Community ============"
echo "====================================================================="

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome*.deb
rm -f google-chrome*.deb

wget http://cdn.change-vision.com/files/astah-community_7.1.0.f2c212-0_all.deb
dpkg -i astah-community*.deb
rm -f astah-community*.deb

echo "==============================================================="
echo "=========== uninstalling some unnecessary packages ============"
echo "==============================================================="

apt-get -y purge libreoffice-base libreoffice-draw libreoffice-math
apt-get -y autoremove
apt-get -y clean

echo "====================================================================="
echo "================= installing AngularJS and Ionic ===================="
echo "====================================================================="

npm install -g yo
npm install -g generator-angular 
npm install -g bower grunt
npm install -g ionic cordova

fi
