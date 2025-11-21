#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
#  PROTOCOL: MDH_GOD_MODE // FINAL_ITERATION
#  TARGET:   TERMUX_HOST_LAYER
#  AUTHOR:   @MDHojayfa
#  VIBE:     SENTIENT_TERMINAL // DARK_OPS
# ==============================================================================

set -euo pipefail
IFS=$'\n\t'

# --- [ NEURAL PALETTE ] ---
ESC="\033["
RST="${ESC}0m"
BOLD="${ESC}1m"
DIM="${ESC}2m"
ITAL="${ESC}3m"
BLINK="${ESC}5m"

# High-Contrast Cyber Palette
NEON_GRN="${ESC}38;5;46m"   # Code/Success
NEON_CYN="${ESC}38;5;51m"   # Interface/Core
NEON_PNK="${ESC}38;5;198m"  # Glitch/Warning
NEON_RED="${ESC}38;5;196m"  # Critical/Blood
DK_GRY="${ESC}38;5;236m"    # Void
WHT="${ESC}38;5;255m"

# --- [ VISUAL ENGINE ] ---

# Impact Flash
impact_thud() {
    printf "${NEON_PNK}"
    printf "█▓▒░ SYSTEM IMPACT ░▒▓█"
    printf "${RST}\n"
}

# Hex Dump Background Boot
boot_sequence() {
    clear
    printf "${DK_GRY}"
    local count=0
    while [ $count -lt 10 ]; do
        local addr=$(printf "%08X" $((RANDOM * RANDOM)))
        local d1=$(printf "%04X" $RANDOM)
        local d2=$(printf "%04X" $RANDOM)
        echo "0x${addr} :: ${d1} ${d2} :: INJECTING_MDH_PROTOCOL..."
        sleep 0.02
        count=$((count + 1))
    done
    printf "${RST}"
    clear
}

# The MDH Banner
show_banner() {
    printf "${NEON_CYN}${BOLD}"
    cat << "EOF"
    █▀▄▀█ █▀▀▄ █░░█   ▀▀█▀▀ █▀▀█ █▀▀█ █░░ █▀▀
    █░▀░█ █░░█ █▀▀█   ░░█░░ █░░█ █░░█ █░░ ▀▀█
    ▀░░░▀ ▀▀▀░ ▀░░▀   ░░▀░░ ▀▀▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀
EOF
    printf "${RST}"
    printf "    ${DIM}>> CREATED BY: ${NEON_GRN}@MDHojayfa${RST}\n"
    printf "    ${DIM}>> STATUS:     ${NEON_RED}UNLEASHED${RST}\n"
    printf "    ${DK_GRY}=========================================${RST}\n\n"
}

# Glitch Text Decoder
glitch_decode() {
    local text="$1"
    local len=${#text}
    local chars="!@#%^&*()_+-=[]{}|;:,.<>?/"
    
    printf "${NEON_PNK}>>${RST} "
    for ((i=0; i<5; i++)); do
        local garbage=""
        for ((j=0; j<len; j++)); do
            garbage+="${chars:$((RANDOM % ${#chars})):1}"
        done
        printf "\r${NEON_PNK}>>${RST} ${DK_GRY}%s${RST}" "$garbage"
        sleep 0.03
    done
    printf "\r${NEON_PNK}>>${RST} ${NEON_GRN}%s${RST}                  \n" "$text"
}

# Matrix Loader
matrix_loader() {
    local pid=$1
    local label=$2
    local chars="10"
    
    printf "${ESC}?25l"
    while kill -0 "$pid" 2>/dev/null; do
        local stream=""
        for k in {1..10}; do stream+="${chars:$((RANDOM % ${#chars})):1}"; done
        printf "\r${NEON_CYN}[%s]${RST} ${label} ${DIM}>> ${stream}${RST}" "${stream:0:1}"
        sleep 0.1
    done
    printf "${ESC}?25h"
    printf "\r${NEON_GRN}[✔]${RST} ${label} ${BOLD}ESTABLISHED.${RST}                            \n"
}

# --- [ CORE LOGIC ] ---

boot_sequence
show_banner
sleep 0.3
impact_thud
glitch_decode "INITIALIZING SENTIENT INSTALLER..."

# 1. HOST PREP
printf "\n${BOLD}${NEON_CYN}>> SCANNING LOCAL HOST...${RST}\n"
(pkg update -y >/dev/null 2>&1 && pkg install -y proot-distro curl >/dev/null 2>&1) &
matrix_loader $! "CORE_DEPENDENCIES"

# 2. DISTRO SELECT
echo
printf "${NEON_RED}╔══════════════════════════════════════╗${RST}\n"
printf "${NEON_RED}║       SELECT INFILTRATION TARGET     ║${RST}\n"
printf "${NEON_RED}╚══════════════════════════════════════╝${RST}\n"
printf "  ${NEON_GRN}[1]${RST} DEBIAN ${DIM}:: STABLE_CORE (Recommended)${RST}\n"
printf "  ${NEON_GRN}[2]${RST} UBUNTU ${DIM}:: HEAVY_ASSAULT${RST}\n"
printf "  ${NEON_GRN}[3]${RST} ALPINE ${DIM}:: LIGHT_RECON${RST}\n"
echo
read -r -p $'\e[38;5;46mMDH@Root\e[0m: \e[1m>>\e[0m ' CHOICE

case "$CHOICE" in
  1) DISTRO="debian";;
  2) DISTRO="ubuntu";;
  3) DISTRO="alpine";;
  *) printf "\n${NEON_RED}[FATAL] SIGNAL LOST.${RST}\n"; exit 1;;
esac

# 3. INSTALL DISTRO
if proot-distro list | grep -qi "^$DISTRO"; then
    glitch_decode "TARGET SYSTEM RESIDENT IN MEMORY."
else
    glitch_decode "DOWNLOADING FILE SYSTEM..."
    (proot-distro install "$DISTRO" >/dev/null 2>&1) &
    matrix_loader $! "DEPLOYING_CONTAINER"
fi

# 4. METHOD SELECTION (The "Fuck It" Safety Net)
echo
printf "${NEON_RED}╔══════════════════════════════════════╗${RST}\n"
printf "${NEON_RED}║       SELECT INJECTION METHOD        ║${RST}\n"
printf "${NEON_RED}╚══════════════════════════════════════╝${RST}\n"
printf "  ${NEON_GRN}[1]${RST} AUTO-INJECT ${DIM}:: (Try to install automatically)${RST}\n"
printf "  ${NEON_GRN}[2]${RST} MANUAL-BREACH ${DIM}:: (Give me the codes to copy-paste)${RST}\n"
echo
read -r -p $'\e[38;5;46mMDH@Root\e[0m: \e[1m>>\e[0m ' METHOD

# --- AUTO INJECTION PATH ---
if [ "$METHOD" = "1" ]; then
    glitch_decode "COMPILING INTERNAL PAYLOAD..."
    
    # We write the internal script to a temp file
    # This script runs INSIDE the distro
    cat << 'EOF' > $PREFIX/tmp/mdh_payload.sh
#!/bin/bash
set -e
echo "nameserver 8.8.8.8" > /etc/resolv.conf
# Install dependencies
if [ -f /etc/alpine-release ]; then
    apk update && apk add curl python3 py3-pip bash
else
    apt-get update -y && apt-get install -y curl python3 python3-pip
fi

# Detect Arch
ARCH=$(uname -m)
if [[ "$ARCH" == "aarch64" ]]; then FILE="google-cloud-cli-linux-arm.tar.gz"; else FILE="google-cloud-cli-linux-x86_64.tar.gz"; fi

# Download & Install
cd /tmp
curl -L -O "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/$FILE"
rm -rf /opt/google-cloud-sdk
mkdir -p /opt
tar -xf "$FILE" -C /opt
/opt/google-cloud-sdk/install.sh --quiet --usage-reporting=false --path-update=true --bash-completion=true

# Symlink
ln -sf /opt/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
ln -sf /opt/google-cloud-sdk/bin/gsutil /usr/bin/gsutil

echo "DONE"
EOF
    chmod +x $PREFIX/tmp/mdh_payload.sh

    glitch_decode "EXECUTING REMOTE SCRIPT..."
    # Run it
    proot-distro login "$DISTRO" -- /bin/bash /data/data/com.termux/files/usr/tmp/mdh_payload.sh || true

    glitch_decode "PAYLOAD DELIVERY COMPLETE."

# --- MANUAL PATH ---
elif [ "$METHOD" = "2" ]; then
    clear
    show_banner
    printf "${NEON_PNK}>> MANUAL OVERRIDE ENGAGED <<${RST}\n\n"
    printf "${WHT}COPY THIS AND PASTE INSIDE THE SHELL:${RST}\n"
    printf "${DK_GRY}----------------------------------------${RST}\n"
    printf "${NEON_GRN}"
    
    if [ "$DISTRO" = "alpine" ]; then
        echo "apk update && apk add curl python3 py3-pip"
        echo "curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-arm.tar.gz"
        echo "tar -xf google-cloud-cli-linux-arm.tar.gz"
        echo "./google-cloud-sdk/install.sh"
    else
        echo "apt update && apt install curl python3 -y"
        echo "curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-arm.tar.gz"
        echo "tar -xf google-cloud-cli-linux-arm.tar.gz"
        echo "./google-cloud-sdk/install.sh"
    fi
    
    printf "${RST}\n${DK_GRY}----------------------------------------${RST}\n"
    printf "${DIM}Press ENTER to launch shell...${RST}"
    read -r
fi

# --- OUTRO ---

printf "\n"
glitch_decode "MISSION REWARD: Please follow me @MDHojayfa on GitHub."
sleep 1
termux-open-url "https://github.com/MDHojayfa" >/dev/null 2>&1 || true

# --- FINAL CONNECTION BLOCK (CORRECTED PLACEMENT) ---

# Print login tip BEFORE the script ends
printf "\n${NEON_PNK}[MEMO]${RST} ${DIM}To access this environment next time, use command:${RST}\n"
printf "       ${BOLD}${NEON_GRN}proot-distro login $DISTRO${RST}\n"

# CLOUD SHELL LOGIN (MOVED HERE)
printf "${NEON_CYN}>> CLOUD SHELL LOGIN: ${BOLD}${ITAL}Use the same command as above, then type 'gcloud cloud-shell ssh' in the shell.${RST}\n"

printf "\n${BOLD}${WHT}JACKING IN NOW...${RST}\n"
sleep 0.5
printf "${NEON_CYN}>> AUTO-INITIALIZING GCLOUD UPLINK...${RST}\n"
sleep 1
clear

# This logs in, runs gcloud init interactively, then drops to a persistent shell.
exec proot-distro login "$DISTRO" -- bash -c "gcloud init; exec bash"
