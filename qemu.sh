echo " project : smicheal id "
echo " youtube : smichael id "
echo " version : 1 "
echo " title   : simple installer"
sleep 5s

apt update -y
apt upgrade -y

apt-get install x11-repo -y
apt-get install qemu-system-x86-64-headless -y
apt-get install qemu-utils -y
apt-get install wget -y

read -p "Create Disk (5GB, 10GB, 20GB): " disk

case "$disk" in
  [5]GB | [5][gG][bB])
    echo "Create 5GB Disk"
    qemu-img create -f raw disk.img 5G
    ;;
  [1][0]GB | [1][0][gG][bB])
    echo "Create 10GB Disk"
    qemu-img create -f raw disk.img 10G
    ;;
  [2][0]GB | [2][0][gG][bB])
    echo "Create 20GB Disk"
    qemu-img create -f raw disk.img 20G
    ;;
  *)
    echo "ERROR :("
    ;;
esac
sleep 5s

clear

file="dsl-4.11.rc2.iso"

if [ -f "$file" ]; then
    echo "files already exist."
else
    echo "file not available yet, start download"
    wget "http://distro.ibiblio.org/damnsmall/release_candidate/dsl-4.11.rc2.iso" -O "$file"
    echo "downloads are complete."
fi

read -p "Size Ram: " ram
read -p "Core 1-8: " core


if [[ $core =~ ^[1-8]$ ]]; then
  echo "cpu ready"
else
  echo "range 1-8"
fi


qemu-system-x86_64 -m $ram -smp $core -hda /data/data/com.termux/files/home/qemu/disk.img -cdrom /data/data/com.termux/files/home/qemu/dsl-4.11.rc2.iso -device rtl8139,netdev=net0 -netdev user,id=net0

