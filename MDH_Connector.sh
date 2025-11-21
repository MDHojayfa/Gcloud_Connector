#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
#  PROJECT: BEAST_CONNECTOR // PROTOCOL FINAL_DEF
#  AUTHOR:  @MDHojayfa
#  STATUS:  GOD_MODE_ACTIVE
#  VISUALS: ULTRA_GLITCH_DENSITY
# ==============================================================================

set -euo pipefail
IFS=$'\n\t'

# --- [ NEURAL PALETTE ] ---
ESC="\033["
RST="${ESC}0m"
BOLD="${ESC}1m"
DIM="${ESC}2m"
ITAL="${ESC}3m"

# Cyberpunk High-Contrast
NEON_GRN="${ESC}38;5;46m"    # Main Data
NEON_CYN="${ESC}38;5;51m"    # UI Elements
NEON_PNK="${ESC}38;5;198m"   # Alerts/Glitch
NEON_RED="${ESC}38;5;196m"   # Critical/Root
DK_GRY="${ESC}38;5;236m"     # Background Noise
WHT="${ESC}38;5;255m"

# --- [ VISUAL FX ENGINE ] ---

# FX: Hex Dump Boot Screen (The "Back of Banner" effect)
boot_sequence() {
    clear
    local rows=$(stty size | cut -d ' ' -f 1)
    local cols=$(stty size | cut -d ' ' -f 2)
    
    # Rapid scrolling hex dump
    printf "${DK_GRY}"
    for i in {1..15}; do
        local addr=$(printf "%08X" $((RANDOM * RANDOM)))
        local data1=$(printf "%04X" $RANDOM)
        local data2=$(printf "%04X" $RANDOM)
        local data3=$(printf "%04X" $RANDOM)
        printf "0x${addr} :: ${data1} ${data2} ${data3} :: MEM_INJECT :: @MDHojayfa\n"
        sleep 0.01
    done
    printf "${RST}"
    
    # Flash effect
    printf "${ESC}?5h"; sleep 0.05; printf "${ESC}?5l"
    clear
}

# FX: The Banner
show_banner() {
    printf "${NEON_CYN}${BOLD}"
    cat << "EOF"
    █▀▄▀█ █▀▀▄ █░░█   ▀▀█▀▀ █▀▀█ █▀▀█ █░░ █▀▀
    █░▀░█ █░░█ █▀▀█   ░░█░░ █░░█ █░░█ █░░ ▀▀█
    ▀░░░▀ ▀▀▀░ ▀░░▀   ░░▀░░ ▀▀▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀
EOF
    printf "${RST}"
    printf "    ${DIM}>> SYSTEM OWNER: ${NEON_GRN}@MDHojayfa${RST}\n"
    printf "    ${DIM}>> PROTOCOL:     ${NEON_RED}UNRESTRICTED${RST}\n"
    printf "    ${DK_GRY}=========================================${RST}\n\n"
}

# FX: Glitch Text Decoder
glitch_msg() {
    local text="$1"
    local len=${#text}
    local chars="!@#%^&*()_+-=[]{}|;:,.<>?/"
    
    for ((i=0; i<6; i++)); do
        local garbage=""
        for ((j=0; j<len; j++)); do
            garbage+="${chars:$((RANDOM % ${#chars})):1}"
        done
        printf "\r${NEON_PNK}[SYS_DECODE]${RST} ${DK_GRY}%s${RST}" "$garbage"
        sleep 0.02
    done
    printf "\r${NEON_GRN}[ACCESS_OK]${RST}  ${NEON_CYN}%s${RST}              \n" "$text"
}

# FX: Cyber Loader with Spinner
cyber_loader() {
    local pid=$1
    local label=$2
    local spin='⣾⣽⣻⢿⡿⣟⣯⣷'
    local i=0
    
    printf "${ESC}?25l"
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i+1) % 8 ))
        printf "\r${NEON_PNK}[%s]${RST} ${label} ${DIM}>> WORKING...${RST}" "${spin:$i:1}"
        sleep 0.1
    done
    printf "${ESC}?25h"
    printf "\r${NEON_GRN}[✔]${RST} ${label} ${BOLD}ESTABLISHED.${RST}                            \n"
}

# --- [ MAIN SEQUENCE ] ---

boot_sequence
show_banner
sleep 0.3

glitch_msg "INITIALIZING @MDHojayfa SECURITY KERNEL..."
printf "\n"

# 1. HOST SCAN
printf "${BOLD}${NEON_CYN}>> SCANNING HOST ENVIRONMENT...${RST}\n"
pkg update -y >/dev/null 2>&1 || true
(pkg install -y proot-distro curl >/dev/null 2>&1) &
cyber_loader $! "DEPENDENCY_INJECTION"

# 2. VECTOR SELECTION
echo
printf "${NEON_RED}[ SELECT ATTACK VECTOR ]${RST}\n"
printf "${DK_GRY}---------------------------------${RST}\n"
printf "${NEON_GRN}[1]${RST} DEBIAN_CORE ${DIM}(Rec. Stable)${RST}\n"
printf "${NEON_GRN}[2]${RST} UBUNTU_CORE ${DIM}(Alternative)${RST}\n"
printf "${DK_GRY}---------------------------------${RST}\n"
echo
read -r -p $'\e[38;5;46mMDH@Root\e[0m: \e[1m>>\e[0m ' CHOICE

case "$CHOICE" in
  1) DISTRO="debian";;
  2) DISTRO="ubuntu";;
  *) printf "\n${NEON_RED}[ERROR] SIGNAL LOST.${RST}\n"; exit 1;;
esac

# 3. CONTAINER DEPLOYMENT
if proot-distro list | grep -qi "^$DISTRO"; then
  printf "${NEON_PNK}[!] SYSTEM:${RST} ${DISTRO} detected in memory.\n"
else
  printf "${NEON_CYN}[*] DOWNLOADING ROOTFS...${RST}\n"
  (proot-distro install "$DISTRO" >/dev/null 2>&1) &
  
  # Matrix Rain Effect during download
  pid=$!
  chars="10"
  while kill -0 "$pid" 2>/dev/null; do
      bin_str=""
      for k in {1..30}; do bin_str+="${chars:$((RANDOM % ${#chars})):1}"; done
      printf "\r${DIM}DOWNLOADING: ${NEON_GRN}%s${RST}" "$bin_str"
      sleep 0.05
  done
  wait "$pid" || true
  printf "\r${NEON_GRN}[✔] PAYLOAD DEPLOYED SUCCESSFULLY.          ${RST}\n"
fi

sleep 0.5
glitch_msg "BREACHING CONTAINER ROOT..."

# 4. INJECTING THE ROBUST INSTALLER (HIDDEN)
# We create a script INSIDE the container to handle the complex install reliably.
printf "${DIM}>> COMPILING GCLOUD INSTALLER SCRIPT...${RST}\n"

cat << 'PAYLOAD' > $PREFIX/tmp/mdh_silent_installer.sh
#!/bin/bash
set -e
GRN='\033[32m'
CYN='\033[36m'
RST='\033[0m'

# Fix DNS & IPv4 (The "Secret Sauce" for reliability)
echo "nameserver 8.8.8.8" > /etc/resolv.conf

printf "${CYN}[CONTAINER] >> INSTALLING DEPENDENCIES...${RST}\n"
apt-get -o Acquire::ForceIPv4=true update -y >/dev/null 2>&1
apt-get -o Acquire::ForceIPv4=true install -y --no-install-recommends curl python3 python3-pip ca-certificates tar gzip >/dev/null 2>&1

printf "${CYN}[CONTAINER] >> FETCHING BINARIES...${RST}\n"
ARCH=$(uname -m)
if [[ "$ARCH" == "aarch64" ]]; then FILE="google-cloud-cli-linux-arm.tar.gz"; else FILE="google-cloud-cli-linux-x86_64.tar.gz"; fi

cd /tmp
curl -L -f -O "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/$FILE" >/dev/null 2>&1

printf "${CYN}[CONTAINER] >> INSTALLING GCLOUD CORE...${RST}\n"
rm -rf /opt/google-cloud-sdk
mkdir -p /opt
tar -xf "$FILE" -C /opt >/dev/null 2>&1
/opt/google-cloud-sdk/install.sh --quiet --usage-reporting=false --path-update=true --bash-completion=true >/dev/null 2>&1

# Symlinks for instant access
ln -sf /opt/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
ln -sf /opt/google-cloud-sdk/bin/gsutil /usr/bin/gsutil

rm -f "/tmp/$FILE"
printf "\n${GRN}[SUCCESS] GCLOUD KERNEL ACTIVE.${RST}\n"
PAYLOAD

chmod +x $PREFIX/tmp/mdh_silent_installer.sh

# 5. EXECUTE INJECTION
# We run the script inside the container, showing its output
proot-distro login "$DISTRO" -- /bin/bash /data/data/com.termux/files/usr/tmp/mdh_silent_installer.sh

# --- [ OUTRO ] ---

printf "\n"
printf "${BOLD}${NEON_PNK}=== SYSTEM INSTALLATION COMPLETE ===${RST}\n"
printf "\n"

# The specific requested line
glitch_msg "MISSION REWARD: Please follow me @MDHojayfa on GitHub."

printf "${DIM}>> ESTABLISHING UPLINK...${RST}\n"
sleep 1
termux-open-url "https://github.com/MDHojayfa" >/dev/null 2>&1 || true

echo
printf "${BOLD}${WHT}WOULD YOU LIKE TO JACK IN NOW? [Y/n] ${RST}"
read -r LOGIN_NOW

if [[ "$LOGIN_NOW" =~ ^[Yy]$ || -z "$LOGIN_NOW" ]]; then
    printf "\n"
    # Final breach animation
    for i in {1..3}; do
        printf "\r${NEON_RED}>> BREACHING FIREWALL..${RST}"
        sleep 0.1
        printf "\r${NEON_RED}>> BREACHING FIREWALL....${RST}"
        sleep 0.1
    done
    clear
    
    # Welcome banner inside the shell
    printf "${NEON_GRN}"
    printf "ACCESS GRANTED.\n"
    printf "Command: 'gcloud init' to begin.\n"
    printf "${RST}\n"
    
    proot-distro login "$DISTRO"
else
    printf "\n${NEON_RED}>> TERMINATING SESSION.${RST}\n"
    printf "Reconnect: ${BOLD}proot-distro login $DISTRO${RST}\n"
    exit 0
fi
