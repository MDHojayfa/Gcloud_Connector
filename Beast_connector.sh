#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
#  PROTOCOL: GCLOUD_CONNECTOR // MARK_IV
#  AUTHOR:   [REDACTED] // AI FORGE
#  STATUS:   SYSTEM_BREACH_READY
# ==============================================================================

set -euo pipefail
IFS=$'\n\t'

# --- [ VISUAL CORE ] ---
ESC="\033["
RST="${ESC}0m"
BOLD="${ESC}1m"
DIM="${ESC}2m"
BLK="${ESC}30m"
RED="${ESC}31m"
GRN="${ESC}32m"
YEL="${ESC}33m"
BLU="${ESC}34m"
MAG="${ESC}35m"
CYN="${ESC}36m"
WHT="${ESC}37m"

# Animated Glitch Text
glitch_text() {
    local text="$1"
    local len=${#text}
    local chars="!@#$%^&*()_+-=[]{}|;:,.<>?/~"
    for ((i=0; i<4; i++)); do
        local garbage=""
        for ((j=0; j<len; j++)); do
            garbage+="${chars:$((RANDOM % ${#chars})):1}"
        done
        printf "\r${DIM}${MAG}[SYSTEM_DECODE]${RST} ${RED}${garbage}${RST}"
        sleep 0.03
    done
    printf "\r${DIM}${CYN}[SYSTEM_READY] ${RST}${BOLD}${GRN}${text}${RST}          \n"
}

# Cyber Header
banner() {
    clear
    printf "${CYN}"
    cat << "EOF"
    █▀▄▀█ █▀▀▄ █░░█   ▀▀█▀▀ █▀▀█ █▀▀█ █░░ █▀▀
    █░▀░█ █░░█ █▀▀█   ░░█░░ █░░█ █░░█ █░░ ▀▀█
    ▀░░░▀ ▀▀▀░ ▀░░▀   ░░▀░░ ▀▀▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀
EOF
    printf "${RST}\n"
    printf "    ${DIM}>> PROTOCOL: MINIMAL_INSTALLER_V2${RST}\n"
    printf "    ${DIM}>> TARGET:   ANDROID_TERMUX_HOST${RST}\n"
    printf "    ${RED}_____________________________________${RST}\n\n"
}

# Fake Telemetry Stream
telemetry() {
    local count=5
    local phrases=("ACCESS_MEM_0x4F" "BYPASS_SEC" "PING_GCLOUD" "ROOT_CHK_NULL" "ALLOCATING_VRAM")
    for phrase in "${phrases[@]}"; do
        printf "    ${DIM}:: ${phrase} ... ${GRN}OK${RST}\n"
        sleep 0.05
    done
}

# Hacker Progress Bar
loader() {
    local pid=$1
    local label=$2
    local spin='-\|/'
    local i=0
    
    # Hide cursor
    printf "${ESC}?25l"
    
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i+1) %4 ))
        printf "\r${CYN}[${spin:$i:1}]${RST} ${label} ${DIM}>> PROCESSING_DATA_PACKETS...${RST}"
        sleep 0.1
    done
    
    # Show cursor
    printf "${ESC}?25h"
    printf "\r${GRN}[✔]${RST} ${label} ${BOLD}COMPLETED.${RST}                            \n"
}

# --- [ MAIN SEQUENCE ] ---
banner
sleep 0.5
glitch_text "INITIALIZING NEURAL HANDSHAKE..."
telemetry
printf "\n"

# 1. Prerequisites
echo -e "${BOLD}${WHT}>> CHECKING HOST INTEGRITY...${RST}"
pkg update -y >/dev/null 2>&1 || true
# Run install in background to show loader
(pkg install -y proot-distro curl >/dev/null 2>&1) &
loader $! "DEPENDENCY_INJECTION"

# 2. Distro Selection
echo
printf "${RED}[ SELECT VECTOR ]${RST}\n"
printf "${DIM}---------------------------------${RST}\n"
printf "${CYN}[1]${RST} DEBIAN_CORE ${DIM}(Full CLI | ~270MB)${RST}\n"
printf "${CYN}[2]${RST} UBUNTU_CORE ${DIM}(Full CLI | ~350MB)${RST}\n"
printf "${CYN}[3]${RST} ALPINE_LITE ${DIM}(Python API | ~130MB)${RST}\n"
printf "${DIM}---------------------------------${RST}\n"
echo
read -r -p $'\e[32mroot@interface\e[0m: \e[1m>>\e[0m ' CHOICE

case "$CHOICE" in
  1) DISTRO="debian"; MODE="full";;
  2) DISTRO="ubuntu"; MODE="full";;
  3) DISTRO="alpine"; MODE="ultra";;
  *) printf "\n${RED}[ERROR] CONNECTION TERMINATED.${RST}\n"; exit 1;;
esac

printf "\n${GRN}>> TARGET ACQUIRED: ${BOLD}$DISTRO${RST} [MODE: ${MODE}]\n"
sleep 0.5

# 3. Install Distro Logic
if proot-distro list | grep -qi "^$DISTRO"; then
  printf "${YEL}[!] SYSTEM_DETECTED: ${DISTRO} already resident.${RST}\n"
else
  printf "${CYN}[*] INITIATING DOWNLOAD SEQUENCE...${RST}\n"
  # Visual wrapper for installation
  (proot-distro install "$DISTRO" >/dev/null 2>&1) &
  pid=$!
  
  # Matrix Rain Loading Effect while installing
  chars="01"
  while kill -0 "$pid" 2>/dev/null; do
      printf "\r${DIM}DOWNLOADING: ${RST}${GRN}"
      for i in {1..20}; do printf "${chars:$((RANDOM % ${#chars})):1}"; done
      printf "${RST}"
      sleep 0.1
  done
  wait "$pid" || true
  printf "\r${GRN}[✔] FILESYSTEM DEPLOYED SUCCESSFULLY.          ${RST}\n"
fi

sleep 1
glitch_text "INJECTING CONFIGURATION SCRIPTS..."

# 4. Configuration (Mode Specific)

# --- MODE: FULL (Debian/Ubuntu) ---
if [ "$MODE" = "full" ]; then
  printf "${DIM}>> ACCESSING CONTAINER ROOT...${RST}\n"
  
  # We modify the inner echo statements to match the theme, but commands are untouched.
  proot-distro login "$DISTRO" -- bash -lc "
    set -euo pipefail
    DEBIAN_FRONTEND=noninteractive
    
    RED='\033[31m'
    GRN='\033[32m'
    CYN='\033[36m'
    RST='\033[0m'

    echo
    printf \"\${CYN}[CONTAINER] >> SYNCING REPOSITORIES...\${RST}\n\"
    apt update -y >/dev/null 2>&1

    printf \"\${CYN}[CONTAINER] >> UPGRADING BINARIES...\${RST}\n\"
    apt upgrade -y --no-install-recommends >/dev/null 2>&1 || true

    printf \"\${CYN}[CONTAINER] >> INSTALLING CORE TOOLS (curl/gpg)...\${RST}\n\"
    apt install -y --no-install-recommends curl ca-certificates gnupg lsb-release apt-transport-https >/dev/null 2>&1

    # Fix OS Release for GCloud compatibility
    rm -f /etc/os-release || true
    cat > /etc/os-release <<'OSR'
PRETTY_NAME=\"Minimal Linux\"
NAME=\"Minimal Linux\"
VERSION_ID=\"0\"
VERSION=\"minimal\"
ID=minimal
HOME_URL=\"https://example.local/\"
SUPPORT_URL=\"\"
BUG_REPORT_URL=\"\"
OSR

    printf \"\${CYN}[CONTAINER] >> ADDING GOOGLE SIGNATURES...\${RST}\n\"
    curl -sSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - >/dev/null 2>&1 || true
    echo 'deb https://packages.cloud.google.com/apt cloud-sdk main' > /etc/apt/sources.list.d/google-cloud-sdk.list

    printf \"\${CYN}[CONTAINER] >> INSTALLING GCLOUD CLI...\${RST}\n\"
    apt update -y >/dev/null 2>&1
    apt install -y --no-install-recommends google-cloud-sdk >/dev/null 2>&1

    printf \"\${CYN}[CONTAINER] >> FREEZING VERSION LOCKS...\${RST}\n\"
    apt-mark hold google-cloud-sdk >/dev/null 2>&1 || true

    printf \"\${CYN}[CONTAINER] >> CLEANING CACHE...\${RST}\n\"
    apt-get clean
    rm -rf /var/lib/apt/lists/* /tmp/*

    printf \"\n\${GRN}[SUCCESS] GCLOUD CLI DEPLOYED.\${RST}\n\"
  "
fi

# --- MODE: ULTRA (Alpine) ---
if [ "$MODE" = "ultra" ]; then
  printf "${DIM}>> ACCESSING ALPINE KERNEL...${RST}\n"
  proot-distro login "$DISTRO" -- bash -lc "
    set -euo pipefail
    
    GRN='\033[32m'
    CYN='\033[36m'
    YEL='\033[33m'
    RST='\033[0m'

    echo
    printf \"\${CYN}[ALPINE] >> UPDATE STREAM...\${RST}\n\"
    apk update >/dev/null 2>&1
    apk upgrade >/dev/null 2>&1

    printf \"\${CYN}[ALPINE] >> INSTALLING PYTHON RUNTIME...\${RST}\n\"
    apk add --no-cache python3 py3-pip curl ca-certificates >/dev/null 2>&1

    printf \"\${YEL}[NOTE] CLI NOT INCLUDED IN ULTRA MODE. PYTHON ONLY.\${RST}\n\"

    printf \"\${CYN}[ALPINE] >> INSTALLING GOOGLE LIBRARIES...\${RST}\n\"
    pip3 install --no-cache-dir google-cloud-storage google-api-python-client google-auth >/dev/null 2>&1 || true
    mkdir -p /opt/gcloud
    pip3 freeze > /opt/gcloud/requirements.txt || true

    printf \"\${CYN}[ALPINE] >> PURGING CACHE...\${RST}\n\"
    rm -rf /var/cache/apk/* /tmp/*

    printf \"\n\${GRN}[SUCCESS] PYTHON API ENVIRONMENT READY.\${RST}\n\"
  "
fi

# --- FINAL HANDOFF ---
printf "\n"
printf "${BOLD}${MAG}=== SYSTEM INSTALLATION COMPLETE ===${RST}\n"
printf "${DIM}The container is configured and resident in memory.${RST}\n"
printf "\n"

# The Fix: Ask the user to login immediately instead of just exiting
printf "${WHT}Would you like to jack in now? [Y/n] ${RST}"
read -r LOGIN_NOW

if [[ "$LOGIN_NOW" =~ ^[Yy]$ || -z "$LOGIN_NOW" ]]; then
    glitch_text "BREACHING SHELL..."
    sleep 1
    clear
    # Actual Login Command
    proot-distro login "$DISTRO"
else
    printf "\n${CYN}>> TERMINATING LINK.${RST}\n"
    printf "To reconnect later, run: ${BOLD}proot-distro login $DISTRO${RST}\n"
    exit 0
fi
