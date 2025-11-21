#!/data/data/com.termux/files/usr/bin/bash
# Ultra Hacker Vibe — Proot-Distro GCloud Minimal Installer (CLI-only)
# Copy-paste in Termux. Minimal / no extra Python libs in full-mode.
# Designed for Debian/Ubuntu (CLI-only) and Alpine (ultra-light Python API).

set -euo pipefail
IFS=$'\n\t'

# -----------------------
# Colors & helpers
# -----------------------
ESC="\033["
RESET="${ESC}0m"
BOLD="${ESC}1m"
DIM="${ESC}2m"
RED="${ESC}31m"
GREEN="${ESC}32m"
YELLOW="${ESC}33m"
CYAN="${ESC}36m"
MAG="${ESC}35m"
WHITE="${ESC}97m"

spinner() {
  local pid=$1
  local delay=0.08
  local spinstr='|/-\'
  while kill -0 "$pid" 2>/dev/null; do
    for i in $(seq 0 3); do
      printf "\r${DIM}${CYAN}   [%c]${RESET}" "${spinstr:i:1}"
      sleep $delay
    done
  done
  printf "\r"
}

glitch_print() {
  # prints a text with a quick glitchy animation
  local text="$1"
  local len=${#text}
  local i j rnd ch out
  out="$text"
  for i in $(seq 1 6); do
    rnd=$((RANDOM % len))
    ch=$(printf "\\x$(printf %x $((33 + RANDOM % 94)))")
    out="${text:0:rnd}${ch}${text:rnd+1}"
    printf "\r${MAG}%s${RESET}" "$out"
    sleep 0.04
  done
  printf "\r${BOLD}${GREEN}%s${RESET}\n" "$text"
}

progress_bar() {
  local pct=$1
  local width=28
  local filled=$(( (pct * width) / 100 ))
  local empty=$(( width - filled ))
  printf "${CYAN}["
  for ((i=0;i<filled;i++)); do printf "#"; done
  for ((i=0;i<empty;i++)); do printf "-"; done
  printf "] ${BOLD}%3d%%${RESET}\r" "$pct"
}

announce() {
  printf "\n${YELLOW}>> %s${RESET}\n" "$1"
}

# -----------------------
# Cyber banner
# -----------------------
clear
printf "\n"
printf "${BOLD}${WHITE}"
printf "   ███╗   ███╗██╗   ██╗ ██████╗ ██████╗ \n"
printf "   ████╗ ████║██║   ██║██╔═══██╗██╔══██╗\n"
printf "   ██╔████╔██║██║   ██║██║   ██║██████╔╝\n"
printf "   ██║╚██╔╝██║██║   ██║██║   ██║██╔══██╗\n"
printf "   ██║ ╚═╝ ██║╚██████╔╝╚██████╔╝██║  ██║\n"
printf "   ╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝\n"
printf "${RESET}"
printf "\n"
glitch_print "MASTER LAUNCH: Proot GCloud Minimal Installer"
printf "\n"

sleep 0.25

# -----------------------
# Ensure base tools in Termux
# -----------------------
announce "Checking Termux prerequisites..."
pkg update -y >/dev/null 2>&1 || true
pkg install -y proot-distro curl >/dev/null 2>&1 & disown_pid=$!
spinner $! || true
printf "${GREEN} OK${RESET}\n"

# Show menu
echo
printf "${BOLD}Select target distro (minimal sizes shown):${RESET}\n"
printf "  ${CYAN}1) Debian${RESET}    — full gcloud CLI (≈ 250–270 MB)\n"
printf "  ${CYAN}2) Ubuntu${RESET}    — full gcloud CLI (≈ 330–350 MB)\n"
printf "  ${CYAN}3) Alpine${RESET}    — Ultra-light (Python API only, ≈ 110–130 MB)\n"
echo
read -r -p $'Choose (1/2/3) → ' CHOICE

case "$CHOICE" in
  1) DISTRO="debian"; MODE="full";;
  2) DISTRO="ubuntu"; MODE="full";;
  3) DISTRO="alpine"; MODE="ultra";;
  *) printf "${RED}Invalid choice. Exiting.${RESET}\n"; exit 1;;
esac

printf "\n${DIM}Selected:${RESET} ${BOLD}${GREEN}$DISTRO${RESET}  ${DIM}mode:${RESET} ${BOLD}$MODE${RESET}\n\n"
sleep 0.6

announce "Preparing to install $DISTRO ..."

# Install distro if missing
if proot-distro list | grep -qi "^$DISTRO"; then
  printf "${YELLOW}→ $DISTRO already installed. Skipping base install.${RESET}\n"
else
  printf "${CYAN}→ Installing $DISTRO (this may take some minutes)...${RESET}\n"
  # show progress "fake" until command finishes
  proot-distro install "$DISTRO" &
  pid=$!
  # visual progress simulation
  p=0
  while kill -0 "$pid" 2>/dev/null; do
    p=$(( (p + 7) % 100 ))
    progress_bar $p
    sleep 0.6
  done
  wait "$pid" || true
  progress_bar 100; printf "\n"
  printf "${GREEN}→ $DISTRO installed.${RESET}\n"
fi

sleep 0.6
glitch_print "SPAWN SHELL & MINIMALIZE"

# -----------------------
# Full-mode (Debian/Ubuntu) — CLI only, no extra Python libs
# -----------------------
if [ "$MODE" = "full" ]; then
  announce "Entering $DISTRO and performing minimal CLI-only setup..."
  proot-distro login "$DISTRO" -- bash -lc "

set -euo pipefail
DEBIAN_FRONTEND=noninteractive

echo
printf \"${CYAN}[*] Updating package lists...${RESET}\n\"
apt update -y >/dev/null 2>&1

printf \"${CYAN}[*] Applying safe minimal upgrade...${RESET}\n\"
apt upgrade -y --no-install-recommends >/dev/null 2>&1 || true

printf \"${CYAN}[*] Installing CLI essentials (curl, ca-certificates, gnupg)...${RESET}\n\"
apt install -y --no-install-recommends curl ca-certificates gnupg lsb-release apt-transport-https >/dev/null 2>&1

# Ensure a clean, simple /etc/os-release (avoid size symlink warnings)
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

printf \"${CYAN}[*] Adding Google Cloud SDK repository...${RESET}\n\"
curl -sSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - >/dev/null 2>&1 || true
echo 'deb https://packages.cloud.google.com/apt cloud-sdk main' > /etc/apt/sources.list.d/google-cloud-sdk.list

printf \"${CYAN}[*] Updating apt and installing google-cloud-sdk (CLI-only)...${RESET}\n\"
apt update -y >/dev/null 2>&1
apt install -y --no-install-recommends google-cloud-sdk >/dev/null 2>&1

printf \"${CYAN}[*] Holding google-cloud-sdk to prevent unexpected upgrades...${RESET}\n\"
apt-mark hold google-cloud-sdk >/dev/null 2>&1 || true

printf \"${CYAN}[*] Final cleanup to save space...${RESET}\n\"
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/*

printf \"\\n${GREEN}✔ Minimal gcloud CLI installed.${RESET}\\n\"
printf \"${YELLOW}→ To enter shell later: proot-distro login $DISTRO${RESET}\\n\"
printf \"${YELLOW}→ Inside the distro run: gcloud init${RESET}\\n\"

"

  announce "Full (CLI-only) setup finished."
  printf "${DIM}No extra Python libraries were installed — minimal footprint preserved.${RESET}\n"
  exit 0
fi

# -----------------------
# Ultra-light mode (Alpine)
# -----------------------
if [ "$MODE" = "ultra" ]; then
  announce "Entering Alpine (ultra-light) — Python API environment (no CLI)."
  proot-distro login "$DISTRO" -- bash -lc "

set -euo pipefail

echo
printf \"${CYAN}[*] Alpine: update & upgrade...${RESET}\n\"
apk update >/dev/null 2>&1
apk upgrade >/dev/null 2>&1

printf \"${CYAN}[*] Installing tiny Python runtime for API work...${RESET}\n\"
apk add --no-cache python3 py3-pip curl ca-certificates >/dev/null 2>&1

printf \"${YELLOW}⚠ Ultra-light mode:${RESET} google-cloud-sdk CLI is NOT installed here.\n\"
printf \"Use Python client libs for API access. To install now: pip3 install google-cloud-storage\\n\"

printf \"${CYAN}[*] (Optional) Installing minimal google python libs and freezing versions to /opt/gcloud/requirements.txt ...${RESET}\n\"
pip3 install --no-cache-dir google-cloud-storage google-api-python-client google-auth >/dev/null 2>&1 || true
mkdir -p /opt/gcloud
pip3 freeze > /opt/gcloud/requirements.txt || true

printf \"${CYAN}[*] Cleaning apk cache...${RESET}\n\"
rm -rf /var/cache/apk/* /tmp/*

printf \"\\n${GREEN}✔ Alpine ultra-light ready.${RESET}\\n\"
printf \"${YELLOW}→ To enter: proot-distro login $DISTRO${RESET}\\n\"
printf \"${YELLOW}→ Python reqs saved at: /opt/gcloud/requirements.txt${RESET}\\n\"

"
  announce "Ultra-light setup finished."
  exit 0
fi

# fallback
echo "${RED}Unexpected error — exiting.${RESET}"
exit 2
