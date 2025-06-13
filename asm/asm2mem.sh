#!/usr/bin/env bash
# ==============================================================================
# build_mem.sh  ──  Assemble + link little-endian MIPS32 and emit big-endian .mem
# Keeps .text, .data, and .rodata sections only.
#
# Usage:
#   ./build_mem.sh  source.s  [output.mem]  [base_addr(hex)]  [--pad N]
#
# Options:
#   --pad N   pad output binary to N bytes (fill with 0x00)
#
# Requirements:
#   mipsel-linux-gnu-as / mipsel-linux-gnu-ld / mipsel-linux-gnu-objcopy
#   xxd  (sudo apt install vim-common)
# ==============================================================================

set -e  # abort on any error

# ---------------- argument parsing -------------------------------------------
PAD_SIZE=0
positional=()

while (( $# )); do
  case "$1" in
    --pad) PAD_SIZE="$2"; shift 2 ;;
    *)     positional+=("$1"); shift ;;
  esac
done
set -- "${positional[@]}"

if [ $# -lt 1 ]; then
  echo "Usage: $(basename "$0") source.s [output.mem] [base_addr] [--pad N]"
  exit 1
fi

SRC="$(realpath "$1")"
OUT="${2:-prog.mem}"
BASE_ADDR="${3:-0x0}"

# ---------------- toolchain commands -----------------------------------------
AS=mipsel-linux-gnu-as
LD=mipsel-linux-gnu-ld
OBJCOPY=mipsel-linux-gnu-objcopy

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT   # auto-cleanup on exit

# 1. assemble
$AS -march=mips32 -o "$TMPDIR/app.o" "$SRC"

# 2. link with explicit entry point _start
$LD -Ttext "$BASE_ADDR" -e _start -o "$TMPDIR/app.elf" "$TMPDIR/app.o"

# 3. objcopy: keep .text, .data, .rodata and reverse bytes per 32-bit word
$OBJCOPY -O binary --reverse-bytes=4 \
        -j .text -j .data -j .rodata \
        "$TMPDIR/app.elf" "$TMPDIR/app_be.bin"

# 4. optional padding
if (( PAD_SIZE > 0 )); then
  dd if=/dev/zero bs=1 count=0 seek="$PAD_SIZE" \
     of="$TMPDIR/app_be.bin" conv=notrunc 2>/dev/null
fi

# 5. dump to .mem (8 hex chars per line for $readmemh)
xxd -p -c 4 "$TMPDIR/app_be.bin" > "$OUT"

echo "Memory image written to $OUT"
