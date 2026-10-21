#!/usr/bin/env bash
# uefi-pruefung.sh
#
# Vorprüfung für die Umstellung einer Legacy-Installation (Fedora Atomic) auf UEFI.
# Sammelt Hardware-/Firmware-Daten und alle Prüfpunkte 1–10 (10 = SMART) in EINER Textdatei.
# Das Skript LIEST nur – es ändert nichts an Platte, Bootloader oder Firmware.
#
# Die Ausgabedatei trägt Mainboard, Rechnername und Zeitpunkt im Namen, z. B.
#   ~/uefi-pruefung_ASUS-P8B75-V_fedora_2026-10-20_1023.txt
# So lassen sich Prüfungen verschiedener PCs auseinanderhalten.
#
# Aufruf (aus Bash oder Nushell):
#   bash uefi-pruefung.sh                    # Systemplatte automatisch über /boot ermitteln
#   bash uefi-pruefung.sh /dev/sdb           # Platte ausdrücklich angeben (z. B. im Live-System)
#   bash uefi-pruefung.sh --smart [/dev/sdX] # zusätzlich SMART aller SSDs/HDDs; fehlt smartctl
#                                            # (Silverblue), läuft es in einem Fedora-Container
#                                            # (braucht Netzwerk, lädt ca. 100 MB)
#   bash uefi-pruefung.sh --smart-long ...   # dazu SMART-Langtest der Systemplatte (wartet!)

set -u

# ── Optionen ──────────────────────────────────────────────────────────────
SMART_CONTAINER=0; SMART_LONG=0
ARGS=()
for a in "$@"; do
    case "$a" in
        --smart)      SMART_CONTAINER=1 ;;
        --smart-long) SMART_CONTAINER=1; SMART_LONG=1 ;;
        -h|--help)    sed -n '2,20p' "$0"; exit 0 ;;
        *)            ARGS+=("$a") ;;
    esac
done
set -- "${ARGS[@]+"${ARGS[@]}"}"

# ── Nicht in Toolbox/Distrobox/Container ausführen ─────────────────────────
if [ -e /run/.toolboxenv ] || [ -e /run/.containerenv ]; then
    echo "Abbruch: Das Skript läuft in einer Toolbox/einem Container."
    echo "Bitte direkt auf dem Host ausführen (Toolbox mit 'exit' verlassen)."
    exit 1
fi

sudo -v || { echo "Abbruch: keine sudo-Rechte."; exit 1; }

# ── Hilfsfunktionen ───────────────────────────────────────────────────────
# dmidecode-Wert lesen; Platzhalter der Hersteller ("System manufacturer",
# "To be filled by O.E.M." …) als leer behandeln
dmi() {
    local v
    v=$(sudo dmidecode -s "$1" 2>/dev/null | head -1 | sed 's/[[:space:]]*$//')
    case "$v" in
        ""|"System manufacturer"|"System Product Name"|"System Version"|\
        "To be filled by O.E.M."|"Default string"|"Not Specified"|"O.E.M.") echo "" ;;
        *) echo "$v" ;;
    esac
}
# für Dateinamen: nur Buchstaben, Ziffern, Punkt, Minus
slug() { echo "$*" | tr ' /' '--' | tr -cd 'A-Za-z0-9.-' | sed 's/--*/-/g; s/^-//; s/-$//'; }
section() { echo; echo "=================================================================="; echo "=== $*"; echo "=================================================================="; }

# smartctl ausführen: lokal, sonst (nur mit --smart) in einem Fedora-Container
SMART_IMG="registry.fedoraproject.org/fedora:44"
SMART_MODE=""
if command -v smartctl >/dev/null; then
    SMART_MODE=local
elif [ "$SMART_CONTAINER" = 1 ] && command -v podman >/dev/null; then
    SMART_MODE=container
fi
smart() {
    case "$SMART_MODE" in
        local)     sudo smartctl "$@" ;;
        container) sudo podman run --rm --privileged -v /dev:/dev "$SMART_IMG" \
                       sh -c 'dnf -y -q install smartmontools >/dev/null 2>&1 && smartctl "$@"' smartctl "$@" ;;
        *)         return 127 ;;
    esac
}
# Kurzauswertung der wichtigsten Attribute (RAW_VALUE)
smart_summary() {
    awk '
    BEGIN {
      w[5]="Reallocated_Sector_Ct      | >0 und steigend: tauschen";
      w[187]="Reported_Uncorrect         | >0: tauschen";
      w[197]="Current_Pending_Sector     | >0: tauschen";
      w[198]="Offline_Uncorrectable      | >0: tauschen";
      w[199]="UDMA_CRC_Error_Count       | >0: Kabel/Port prüfen";
      w[169]="Restlebensdauer (herst.)   | <10 %: tauschen";
      w[231]="SSD_Life_Left              | <10 %: tauschen";
      w[233]="Media_Wearout/NAND (herst.)| herstellerabhängig";
      w[174]="Unexpect_Power_Loss_Ct     | hoch: harte Abschaltungen";
      w[192]="Power-Off_Retract_Count    | hoch: harte Abschaltungen";
      w[9]="Power_On_Hours             | Alter";
      w[12]="Power_Cycle_Count          | Vergleich zu 174/192";
    }
    $1 ~ /^[0-9]+$/ && ($1 in w) { split(w[$1], a, "\\| "); printf "  %3s %-24s RAW=%-10s %s\n", $1, $2, $10, a[2] }'
}
run() { echo; echo "\$ $*"; "$@" 2>&1; }

# ── Hardware erkennen → Dateiname ─────────────────────────────────────────
SYS_VENDOR=$(dmi system-manufacturer)
SYS_PRODUCT=$(dmi system-product-name)
BB_VENDOR=$(dmi baseboard-manufacturer)
BB_PRODUCT=$(dmi baseboard-product-name)
BIOS_VENDOR=$(dmi bios-vendor)
BIOS_VERSION=$(dmi bios-version)
BIOS_DATE=$(dmi bios-release-date)

# Mainboard bevorzugen (Eigenbau-PCs), sonst Systemmodell (Fertig-PCs, Notebooks)
if [ -n "$BB_PRODUCT" ]; then
    VENDOR_SHORT=$(echo "$BB_VENDOR" | awk '{print $1}')   # "ASUSTeK COMPUTER INC." → ASUSTeK
    case "$VENDOR_SHORT" in ASUSTeK) VENDOR_SHORT=ASUS ;; esac
    PCNAME="${VENDOR_SHORT:+$VENDOR_SHORT-}$BB_PRODUCT"
elif [ -n "$SYS_PRODUCT" ]; then
    PCNAME="${SYS_VENDOR:+$(echo "$SYS_VENDOR" | awk '{print $1}')-}$SYS_PRODUCT"
else
    PCNAME="unbekannt"
fi
OUT="$HOME/uefi-pruefung_$(slug "$PCNAME")_$(slug "$(hostname)")_$(date +%F_%H%M).txt"

# ── Systemplatte bestimmen ────────────────────────────────────────────────
if [ $# -ge 1 ]; then
    DISK="$1"
else
    BOOTDEV=$(findmnt -no SOURCE /boot 2>/dev/null)
    if [ -z "$BOOTDEV" ]; then
        echo "Abbruch: /boot ist nicht eingehängt (Live-System?). Platte bitte angeben:"
        echo "  bash $0 /dev/sdX      Übersicht: lsblk -o NAME,SIZE,MODEL"
        exit 1
    fi
    DISK="/dev/$(lsblk -no PKNAME "$BOOTDEV" | head -1)"
fi
if [ ! -b "$DISK" ]; then
    echo "Abbruch: $DISK ist kein Blockgerät."
    exit 1
fi

echo "PC: $PCNAME · Systemplatte: $DISK"
echo "Ausgabe: $OUT"

# ── Prüfungen ─────────────────────────────────────────────────────────────
{
    echo "uefi-pruefung.sh · $(date '+%F %T') · Rechner: $(hostname)"

    section "Hardware und Firmware"
    echo "System-Hersteller : ${SYS_VENDOR:-(Platzhalter/leer)}"
    echo "System-Modell     : ${SYS_PRODUCT:-(Platzhalter/leer)}"
    echo "Mainboard         : ${BB_VENDOR:-?} ${BB_PRODUCT:-?}"
    echo "BIOS              : ${BIOS_VENDOR:-?} · Version ${BIOS_VERSION:-?} · ${BIOS_DATE:-?}"
    run uname -r
    run grep -m1 'model name' /proc/cpuinfo
    run lsblk -d -o NAME,SIZE,MODEL,TRAN,TYPE

    section "Punkt 1: Aktueller Boot-Modus"
    if [ -d /sys/firmware/efi ]; then
        echo "Boot-Modus: UEFI"
        run efibootmgr -v
        command -v mokutil >/dev/null && run mokutil --sb-state
    else
        echo "Boot-Modus: Legacy/BIOS (CSM)"
        echo "Hinweis: Ob die Firmware zusätzlich UEFI erlaubt (Mischmodus), zeigt nur"
        echo "das Bootmenü mit Stick: erscheint er auch als 'UEFI: <Stick>'?"
    fi

    section "Punkt 2: Partitionstabelle ($DISK)"
    run sudo fdisk -l "$DISK"

    section "Punkt 3: Partitionen, Typen, Dateisysteme"
    run lsblk -o NAME,SIZE,FSTYPE,PARTTYPENAME,UUID,MOUNTPOINTS "$DISK"
    echo; echo "--- blkid (zuverlässige Dateisystem-Typen und UUIDs)"
    for p in "$DISK"?*; do
        [ -b "$p" ] || continue
        sudo blkid "$p" 2>&1 || echo "$p: (kein Dateisystem, z. B. BIOS boot)"
    done

    section "Punkt 4: Freier Platz"
    run sudo sfdisk -F "$DISK"          # freie Bereiche (util-linux, immer vorhanden)
    if findmnt -no FSTYPE /sysroot 2>/dev/null | grep -q btrfs; then
        run sudo btrfs filesystem usage -h /sysroot
    else
        echo "/sysroot ist kein btrfs oder nicht eingehängt: $(findmnt -no FSTYPE /sysroot 2>/dev/null)"
    fi

    section "Punkt 5: Verschlüsselung"
    if lsblk -lno TYPE "$DISK" | grep -q crypt; then
        echo "ACHTUNG: LUKS/crypt gefunden"
        run lsblk -o NAME,TYPE,FSTYPE "$DISK"
    else
        echo "Keine crypt-Geräte auf $DISK"
    fi

    section "Punkt 6: Bootloader-Verwaltung (bootupd)"
    run rpm -q bootupd
    if command -v bootupctl >/dev/null; then
        run sudo bootupctl status
    else
        echo "bootupctl nicht vorhanden"
    fi
    run ls /usr/lib/bootupd/grub2-static/
    echo; echo "--- /boot/grub2/bootuuid.cfg"
    sudo cat /boot/grub2/bootuuid.cfg 2>&1

    section "Punkt 7: EFI-Dateien im System-Image"
    run ls /usr/lib/bootupd/updates/
    echo; echo "\$ sudo find /usr/lib/efi -type f"
    sudo find /usr/lib/efi -type f 2>&1 | head -40
    run rpm -q shim-x64 grub2-efi-x64

    section "Punkt 8: fstab"
    run cat /etc/fstab

    section "Punkt 9: Zur Sicherung notieren"
    command -v rpm-ostree >/dev/null && run rpm-ostree status
    command -v flatpak >/dev/null && run flatpak list --app --columns=application
    if command -v ostree >/dev/null; then
        echo; echo "\$ sudo ostree admin config-diff   (erste 60 Zeilen)"
        sudo ostree admin config-diff 2>&1 | head -60
    fi

    section "Punkt 10: SSD-/Plattenzustand (SMART)"
    if [ -z "$SMART_MODE" ]; then
        echo "smartctl nicht verfügbar."
        echo "  Live-System:  sudo dnf install -y smartmontools, dann Skript erneut starten"
        echo "  Silverblue:   Skript mit --smart starten (Fedora-Container, braucht Netzwerk)"
        echo "                oder App 'Laufwerke' → Platte → ⋮ → SMART-Werte und Selbsttests"
    else
        echo "smartctl: $SMART_MODE"
        for d in $(lsblk -dnpo NAME,TYPE | awk '$2=="disk" && $1 !~ /zram|loop/ {print $1}'); do
            echo; echo "------------------------------------------------------------------"
            echo "--- $d  ($(lsblk -dno MODEL,SIZE,TRAN "$d" | xargs))"
            echo "------------------------------------------------------------------"
            if [ "$d" = "$DISK" ] && [ "$SMART_LONG" = 1 ]; then
                echo; echo "\$ smartctl -t long $d"
                smart -t long "$d" | grep -iE "test will complete|please wait|testing has begun"
                echo "Warte auf Ende des Langtests (Abfrage jede Minute) …"
                for _ in $(seq 1 180); do
                    smart -c "$d" | grep -q "in progress" || break
                    smart -c "$d" | grep -A1 "Self-test execution status" | tail -1 | xargs
                    sleep 60
                done
                echo; echo "\$ smartctl -l selftest $d"
                smart -l selftest "$d"
            fi
            echo; echo "--- Kurzauswertung (RAW-Werte, Schwellen siehe rechts)"
            smart -A "$d" | smart_summary
            echo; echo "\$ smartctl -x $d"
            smart -x "$d"
        done
        [ "$SMART_LONG" = 1 ] || echo -e "\nHinweis: Langtest mit --smart-long (liest jeden Sektor, dauert einige Minuten)."
    fi
} 2>&1 | tee "$OUT"

echo
echo "Fertig. Bitte diese Datei schicken:"
echo "  $OUT"
