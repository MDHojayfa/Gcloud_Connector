#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
#  PROJECT: BEAST_CONNECTOR // PROTOCOL V.5
#  AUTHOR:  @MDHojayfa
#  SOURCE:  GITHUB.COM/MDHojayfa
#  STATUS:  OPERATIONAL
# ==============================================================================

set -euo pipefail
IFS=$'\n\t'

# --- [ VISUAL CORE ] ---
# ANSI Escape Codes
ESC="\033["
RST="${ESC}0m"
BOLD="${ESC}1m"
DIM="${ESC}2m"
BLINK="${ESC}5m"

# Cyber Palette
NEON_GRN="${ESC}38;5;46m"   # Matrix Green
NEON_CYN="${ESC}38;5;51m"   # Cyber Blue
NEON_PNK="${ESC}38;5;198m"  # Hot Pink
NEON_RED="${ESC}38;5;196m"  # Critical Red
DK_GRY="${ESC}38;5;236m"    # Dark Grey

# --- [ HELPER FUNCTIONS ] ---

# Safe Glitch Text (Fixed the printf bug)
glitch_msg() {
    local text="$1"
    local len=${#text}
    local chars="!@#%^&*()_+-=[]{}|;:,.<>?/"
    
    # Rapid decode effect
    for ((i=0; i<5; i++)); do
        local garbage=""
        for ((j=0; j<len; j++)); do
            garbage+="${chars:$((RANDOM % ${#chars})):1}"
        done
        # SAFE PRINTF: Uses %s to avoid formatting errors
        printf "\r${DIM}${NEON_PNK}[DECRYPTING]${RST} ${NEON_RED}%s${RST}" "$garbage"
        sleep 0.02
    done
    printf "\r${NEON_GRN}[ACCESS_OK]${RST}  ${BOLD}${NEON_CYN}%s${RST}              \n" "$text"
}

# Matrix Hex Dump Boot
boot_sequence() {
    clear
    printf "${DK_GRY}"
    for i in {1..4}; do
        echo "0x$(printf '%04x' $RANDOM) 0000 0x$(printf '%04x' $RANDOM) :: MEM_ALLOC :: @MDHojayfa"
        sleep 0.03
    done
    printf "${RST}"
}

# Banner: MDH TOOLS
show_banner() {
    printf "${NEON_CYN}${BOLD}"
    cat << "EOF"
    █▀▄▀█ █▀▀▄ █░░█   ▀▀█▀▀ █▀▀█ █▀▀█ █░░ █▀▀
    █░▀░█ █░░█ █▀▀█   ░░█░░ █░░█ █░░█ █░░ ▀▀█
    ▀░░░▀ ▀▀▀░ ▀░░▀   ░░▀░░ ▀▀▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀
EOF
    printf "${RST}"
    printf "    ${DIM}>> CREATED BY: ${NEON_GRN}@MDHojayfa${RST}\n"
    printf "    ${DIM}>> SYSTEM:     ${NEON_RED}BEAST_MODE_ACTIVATED${RST}\n"
    printf "    ${DK_GRY}=========================================${RST}\n\n"
}

# Progress Loader
cyber_loader() {
    local pid=$1
    local label=$2
    local spin='⣾⣽⣻⢿⡿⣟⣯⣷'
    local i=0
    
    printf "${ESC}?25l" # Hide cursor
    
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i+1) % 8 ))
        # Safe printf used
        printf "\r${NEON_PNK}[%s]${RST} ${label} ${DIM}>> PROCESSING...${RST}" "${spin:$i:1}"
        sleep 0.08
    done
    
    printf "${ESC}?25h" # Show cursor
    printf "\r${NEON_GRN}[✔]${RST} ${label} ${BOLD}COMPLETE.${RST}                             \n"
}

# --- [ MAIN LOGIC ] ---

boot_sequence
show_banner
sleep 0.5

glitch_msg "INITIALIZING @MDHojayfa SECURITY PROTOCOLS..."
printf "\n"

# 1. CHECK DEPENDENCIES
printf "${BOLD}${NEON_CYN}>> SCANNING HOST ENVIRONMENT...${RST}\n"
pkg update -y >/dev/null 2>&1 || true
(pkg install -y proot-distro curl >/dev/null 2>&1) &
cyber_loader $! "INJECTING_DEPENDENCIES"

# 2. SELECTION MENU
echo
printf "${NEON_RED}[ SELECT ATTACK VECTOR ]${RST}\n"
printf "${DK_GRY}---------------------------------${RST}\n"
printf "${NEON_GRN}[1]${RST} DEBIAN_CORE ${DIM}(Full CLI | ~270MB)${RST}\n"
printf "${NEON_GRN}[2]${RST} UBUNTU_CORE ${DIM}(Full CLI | ~350MB)${RST}\n"
printf "${NEON_GRN}[3]${RST} ALPINE_LITE ${DIM}(Python API | ~130MB)${RST}\n"
printf "${DK_GRY}---------------------------------${RST}\n"
echo
read -r -p $'\e[38;5;46mMDH@Root\e[0m: \e[1m>>\e[0m ' CHOICE

case "$CHOICE" in
  1) DISTRO="debian"; MODE="full";;
  2) DISTRO="ubuntu"; MODE="full";;
  3) DISTRO="alpine"; MODE="ultra";;
  *) printf "\n${NEON_RED}[ERROR] INVALID INPUT. SYSTEM HALT.${RST}\n"; exit 1;;
esac

printf "\n${NEON_CYN}>> TARGET LOCKED:${RST} ${BOLD}$DISTRO${RST} [MODE: ${MODE}]\n"
sleep 0.5

# 3. INSTALLATION
if proot-distro list | grep -qi "^$DISTRO"; then
  printf "${NEON_PNK}[!] SYSTEM DETECTED:${RST} ${DISTRO} is already resident.\n"
else
  printf "${NEON_CYN}[*] DOWNLOADING PAYLOAD...${RST}\n"
  
  (proot-distro install "$DISTRO" >/dev/null 2>&1) &
  pid=$!
  
  # Matrix Rain Effect
  chars="10"
  while kill -0 "$pid" 2>/dev/null; do
      # Generate random binary string
      bin_str=""
      for k in {1..25}; do bin_str+="${chars:$((RANDOM % ${#chars})):1}"; done
      printf "\r${DIM}SYNC: ${NEON_GRN}%s${RST}" "$bin_str"
      sleep 0.08
  done
  wait "$pid" || true
  printf "\r${NEON_GRN}[✔] PAYLOAD DEPLOYED SUCCESSFULLY.          ${RST}\n"
fi

sleep 0.5
glitch_msg "CONFIGURING MDH_TOOLS CONTAINER..."

# 4. CONFIGURATION LOGIC
if [ "$MODE" = "full" ]; then
  printf "${DIM}>> ESTABLISHING ROOT LINK...${RST}\n"
  
  proot-distro login "$DISTRO" -- bash -lc "
    set -euo pipefail
    DEBIAN_FRONTEND=noninteractive
    
    # Inner Colors
    CYN='\033[36m'
    GRN='\033[32m'
    RST='\033[0m'

    echo
    printf \"\${CYN}[CONTAINER] >> SYNCING PACKAGES...\${RST}\n\"
    apt update -y >/dev/null 2>&1
    apt upgrade -y --no-install-recommends >/dev/null 2>&1 || true

    printf \"\${CYN}[CONTAINER] >> INSTALLING ESSENTIALS...\${RST}\n\"
    apt install -y --no-install-recommends curl ca-certificates gnupg lsb-release apt-transport-https >/dev/null 2>&1

    # OS Release Fix
    rm -f /etc/os-release || true
    cat > /etc/os-release <<'OSR'
PRETTY_NAME=\"MDH Linux\"
NAME=\"MDH Linux\"
VERSION_ID=\"0\"
VERSION=\"minimal\"
ID=minimal
HOME_URL=\"https://github.com/MDHojayfa\"
OSR

    printf \"\${CYN}[CONTAINER] >> ADDING GCLOUD KEYS...\${RST}\n\"
    curl -sSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - >/dev/null 2>&1 || true
    echo 'deb https://packages.cloud.google.com/apt cloud-sdk main' > /etc/apt/sources.list.d/google-cloud-sdk.list

    printf \"\${CYN}[CONTAINER] >> INSTALLING GCLOUD CLI...\${RST}\n\"
    apt update -y >/dev/null 2>&1
    apt install -y --no-install-recommends google-cloud-sdk >/dev/null 2>&1
    
    # Cleanup
    apt-get clean
    rm -rf /var/lib/apt/lists/* /tmp/*

    printf \"\n\${GRN}[SUCCESS] FULL CLI ENVIRONMENT READY.\${RST}\n\"
  "

elif [ "$MODE" = "ultra" ]; then
  printf "${DIM}>> ESTABLISHING ALPINE LINK...${RST}\n"
  proot-distro login "$DISTRO" -- bash -lc "
    set -euo pipefail
    CYN='\033[36m'
    GRN='\033[32m'
    RST='\033[0m'

    echo
    printf \"\${CYN}[ALPINE] >> UPDATING...\${RST}\n\"
    apk update >/dev/null 2>&1
    apk upgrade >/dev/null 2>&1

    printf \"\${CYN}[ALPINE] >> INSTALLING PYTHON...\${RST}\n\"
    apk add --no-cache python3 py3-pip curl ca-certificates >/dev/null 2>&1

    printf \"\${CYN}[ALPINE] >> INSTALLING GOOGLE LIBS...\${RST}\n\"
    pip3 install --no-cache-dir google-cloud-storage google-api-python-client google-auth >/dev/null 2>&1 || true
    mkdir -p /opt/gcloud
    pip3 freeze > /opt/gcloud/requirements.txt || true

    rm -rf /var/cache/apk/* /tmp/*
    printf \"\n\${GRN}[SUCCESS] PYTHON API ENVIRONMENT READY.\${RST}\n\"
  "
fi

# --- [ OUTRO & GITHUB LINK ] ---

printf "\n"
printf "${BOLD}${NEON_PNK}=== SYSTEM INSTALLATION COMPLETE ===${RST}\n"
printf "\n"

# GitHub Auto-Open Sequence
printf "${NEON_CYN}>> INITIATING SOCIAL UPLINK: @MDHojayfa${RST}\n"
sleep 0.5
printf "${DIM}>> OPENING GITHUB REPOSITORY...${RST}\n"

# Try to open URL, suppress output
termux-open-url "https://github.com/MDHojayfa" >/dev/null 2>&1 || true

printf "${NEON_GRN}>> CONNECTED.${RST}\n"
echo

# Final Login Prompt
printf "${BOLD}${WHT}WOULD YOU LIKE TO JACK IN NOW? [Y/n] ${RST}"
read -r LOGIN_NOW

if [[ "$LOGIN_NOW" =~ ^[Yy]$ || -z "$LOGIN_NOW" ]]; then
    glitch_msg "BREACHING SHELL..."
    sleep 0.5
    clear
    proot-distro login "$DISTRO"
else
    printf "\n${NEON_RED}>> TERMINATING SESSION.${RST}\n"
    printf "Reconnect command: ${BOLD}proot-distro login $DISTRO${RST}\n"
    exit 0
fi
