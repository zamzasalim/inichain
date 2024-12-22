#!/bin/bash

curl -s https://data.zamzasalim.xyz/file/uploads/asclogo.sh | bash
sleep 5

echo "INICHAIN NODE"
sleep 2

# 1. Cek dan Install Screen Jika Belum Terinstal
echo "Memeriksa apakah screen sudah terinstal..."
if ! command -v screen &> /dev/null
then
    echo "Screen tidak ditemukan, menginstal..."
    # Perintah untuk menginstal screen berdasarkan distribusi Linux
    if [[ -f /etc/debian_version ]]; then
        sudo apt update && sudo apt install -y screen
    elif [[ -f /etc/redhat-release ]]; then
        sudo yum install -y screen
    else
        echo "Distribusi tidak dikenali, harap instal screen secara manual."
        exit 1
    fi
else
    echo "Screen sudah terinstal."
fi

sudo ufw allow ssh
sudo ufw enable
sudo ufw status

# 3. Unduh File Miner IniChain
echo "Mengunduh file miner..."
sudo wget https://github.com/Project-InitVerse/ini-miner/releases/download/v1.0.0/iniminer-linux-x64

# 4. Berikan Izin Eksekusi
echo "Memberikan izin eksekusi pada file..."
chmod +x iniminer-linux-x64

# 5. Meminta Input Wallet dan Worker
echo "Masukkan address Anda:"
read wallet
echo "Masukkan nama worker Anda:"
read worker

# 6. Jalankan Miner dalam Sesi Screen Baru
echo "Done Bang. Cek gunakan 'screen -r inichain' & keluar gunakan CTRL+AD"
screen -S inichain -d -m ./iniminer-linux-x64 --pool stratum+tcp://$wallet.$worker@pool-core-testnet.inichain.com:32672 --cpu-devices 2
