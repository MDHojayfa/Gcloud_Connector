#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
#  PROJECT: BEAST_CONNECTOR // PROTOCOL V.3 (FIXED)
#  AUTHOR:  @MDHojayfa
#  STATUS:  COMBAT_READY // NO_FAIL_MODE
# ==============================================================================

set -euo pipefail
IFS=$'\n\t'

# --- [ VISUAL CORE ] ---
ESC="\033["
RST="${ESC}0m"
BOLD="${ESC}1m"
DIM="${ESC}2m"

# Cyber Palette
NEON_GRN="${ESC}38;5;46m"
NEON_CYN="${ESC}38;5;51m"
NEON_PNK="${ESC}38;5;198m"
NEON_RED="${ESC}38;5;196m"
DK_GRY="${ESC}38;5;236m"

# --- [ HELPER FUNCTIONS ] ---

glitch_msg() {
    local text="$1"
    # Safe printf to avoid format errors
    printf "\r${NEON_PNK}[SYS_OP]${RST} ${DIM}>>${RST} ${NEON_CYN}%s${RST}\n" "$text"
    sleep 0.1
}

# Banner: MDH TOOLS
show_banner() {
    clear
    printf "${NEON_RED}${BOLD}"
    cat << "EOF"
    █▀▄▀█ █▀▀▄ █░░█   ▀▀█▀▀ █▀▀█ █▀▀█ █░░ █▀▀
    █░▀░█ █░░█ █▀▀█   ░░█░░ █░░█ █░░█ █░░ ▀▀█
    ▀░░░▀ ▀▀▀░ ▀░░▀   ░░▀░░ ▀▀▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀
EOF
    printf "${RST}\n"
    printf "    ${DIM}>> CREATED BY: ${NEON_GRN}@MDHojayfa${RST}\n"
    printf "    ${DIM}>> STATUS:     ${NEON_GRN}SYSTEM_OVERRIDE_ACTIVE${RST}\n"
    printf "    ${DK_GRY}=========================================${RST}\n\n"
}

cyber_loader() {
    local pid=$1
    local label=$2
    local spin='⣾⣽⣻⢿⡿⣟⣯⣷'
    local i=0
    
    printf "${ESC}?25l"
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i+1) % 8 ))
        printf "\r${NEON_CYN}[%s]${RST} ${label} ${DIM}>> WORKING...${RST}" "${spin:$i:1}"
        sleep 0.1
    done
    printf "${ESC}?25h"
    printf "\r${NEON_GRN}[✔]${RST} ${label} ${BOLD}DONE.${RST}                                 \n"
}

# --- [ MAIN LOGIC ] ---

show_banner
glitch_msg "INITIALIZING MDH_TOOLS PROTOCOLS..."

# 1. CHECK HOST
printf "${BOLD}${NEON_CYN}>> CHECKING TERMUX INTEGRITY...${RST}\n"
# We ensure dependencies exist without breaking flow
pkg update -y >/dev/null 2>&1 || true
(pkg install -y proot-distro curl >/dev/null 2>&1) &
cyber_loader $! "HOST_DEPENDENCIES"

# 2. MENU
echo
printf "${NEON_RED}[ TARGET SELECTION ]${RST}\n"
printf "${DK_GRY}---------------------------------${RST}\n"
printf "${NEON_GRN}[1]${RST} DEBIAN ${DIM}(Recommended)${RST}\n"
printf "${NEON_GRN}[2]${RST} UBUNTU ${DIM}(Alternative)${RST}\n"
printf "${DK_GRY}---------------------------------${RST}\n"
echo
read -r -p $'\e[38;5;46mMDH@Root\e[0m: \e[1m>>\e[0m ' CHOICE

case "$CHOICE" in
  1) DISTRO="debian";;
  2) DISTRO="ubuntu";;
  *) printf "\n${NEON_RED}[ERROR] INVALID SELECTION.${RST}\n"; exit 1;;
esac

# 3. INSTALL DISTRO
if proot-distro list | grep -qi "^$DISTRO"; then
  printf "${NEON_PNK}[!] SYSTEM:${RST} ${DISTRO} detected. proceeding to payload injection.\n"
else
  printf "${NEON_CYN}[*] DOWNLOADING LINUX CONTAINER...${RST}\n"
  (proot-distro install "$DISTRO" >/dev/null 2>&1) &
  cyber_loader $! "INSTALLING_FS"
fi

sleep 0.5
glitch_msg "BREACHING CONTAINER ROOT..."

# 4. THE PAYLOAD (Manual Install Method - 100% Reliable)
# We do not use apt for gcloud anymore. We download the binary directly.
printf "${DIM}>> EXECUTING REMOTE SCRIPT...${RST}\n"

proot-distro login "$DISTRO" -- bash -lc "
    set -e
    
    # Internal variables
    CYN='\033[36m'
    GRN='\033[32m'
    RED='\033[31m'
    RST='\033[0m'
    
    echo
    printf \"\${CYN}[CONTAINER] >> INSTALLING CORE UTILS (Python/Curl)...\${RST}\n\"
    apt update -y >/dev/null 2>&1
    # We need python3 for gcloud to run
    apt install -y --no-install-recommends curl python3 python3-pip ca-certificates tar gzip >/dev/null 2>&1

    printf \"\${CYN}[CONTAINER] >> DETECTING ARCHITECTURE...\${RST}\n\"
    ARCH=\$(uname -m)
    if [[ \"\$ARCH\" == \"aarch64\" ]]; then
        FILE=\"google-cloud-cli-linux-arm.tar.gz\"
    else
        FILE=\"google-cloud-cli-linux-x86_64.tar.gz\"
    fi
    printf \"\${GRN}>> ARCH DETECTED: \$ARCH (Target: \$FILE)\${RST}\n\"

    printf \"\${CYN}[CONTAINER] >> DOWNLOADING RAW GCLOUD BINARIES...\${RST}\n\"
    cd /tmp
    # Download directly from Google
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/\$FILE >/dev/null 2>&1

    printf \"\${CYN}[CONTAINER] >> EXTRACTING TO /opt/google-cloud-sdk...\${RST}\n\"
    # Remove old if exists
    rm -rf /opt/google-cloud-sdk
    mkdir -p /opt
    tar -xf \$FILE -C /opt >/dev/null 2>&1
    
    printf \"\${CYN}[CONTAINER] >> INSTALLING BINARY SYMLINKS...\${RST}\n\"
    # Run the install script in quiet mode, no prompts
    /opt/google-cloud-sdk/install.sh --quiet --usage-reporting=false --path-update=true --bash-completion=true >/dev/null 2>&1
    
    # FORCE SYMLINK to /usr/bin so it works INSTANTLY
    ln -sf /opt/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
    ln -sf /opt/google-cloud-sdk/bin/gsutil /usr/bin/gsutil
    ln -sf /opt/google-cloud-sdk/bin/bq /usr/bin/bq

    # Verify Installation
    if command -v gcloud >/dev/null 2>&1; then
        printf \"\n\${GRN}[SUCCESS] GCLOUD INSTALLED & VERIFIED.\${RST}\n\"
        printf \"\${GRN}>> LOCATION: \$(which gcloud)\${RST}\n\"
    else
        printf \"\n\${RED}[FATAL] GCLOUD INSTALL FAILED.\${RST}\n\"
        exit 1
    fi
    
    # Clean up
    rm -f /tmp/\$FILE
"

# --- [ OUTRO ] ---

printf "\n"
printf "${BOLD}${NEON_PNK}=== SETUP COMPLETE ===${RST}\n"

# GitHub Link
printf "${NEON_CYN}>> OPENING @MDHojayfa GITHUB...${RST}\n"
termux-open-url "https://github.com/MDHojayfa" >/dev/null 2>&1 || true
sleep 1

# THE LOGIN FIX
# We ask, but we default to YES if they just hit enter.
printf "${BOLD}${WHT}SYSTEM READY. ENTER SHELL NOW? [Y/n] ${RST}"
read -r LOGIN_NOW

# Logic: If Empty OR Y/y, we login.
if [[ -z "$LOGIN_NOW" || "$LOGIN_NOW" =~ ^[Yy]$ ]]; then
    glitch_msg "AUTHENTICATING..."
    sleep 0.5
    clear
    # This is the command that puts you in the shell
    proot-distro login "$DISTRO"
else
    printf "\n${NEON_RED}>> DISCONNECTED.${RST}\n"
    printf "To connect later type: ${BOLD}proot-distro login $DISTRO${RST}\n"
    exit 0
fi
