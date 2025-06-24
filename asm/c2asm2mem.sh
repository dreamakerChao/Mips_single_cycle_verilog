#!/usr/bin/env bash
# ==============================================================================
# build_mips_be.sh ── Compile MIPS32 C file (little-endian toolchain) to Big-endian .s and .mem
#
# Usage:
#   ./build_mips_be.sh input.c [output_basename] [base_addr(hex)] [--pad N]
#
# Output:
#   output_basename.s     ── MIPS32 assembly
#   output_basename.mem   ── Big-endian memory file for Verilog ($readmemh)
#   output_basename.dis   ── Disassembly of generated binary for visual comparison with .s
#
# Requirements:
#   mipsel-linux-gnu-gcc / as / ld / objcopy / objdump
#   xxd
# ==============================================================================

set -e

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
  echo "Usage: $(basename "$0") input.c [output_base] [base_addr] [--pad N]"
  exit 1
fi

SRC_C="$1"
OUT_BASE="${2:-prog}"
BASE_ADDR="${3:-0x0}"

SRC_S="${OUT_BASE}.s"
OUT_MEM="${OUT_BASE}.mem"
OUT_DIS="${OUT_BASE}.dis"

# Use LITTLE-endian toolchain and convert to BIG-endian output
GCC=mipsel-linux-gnu-gcc
AS=mipsel-linux-gnu-as
LD=mipsel-linux-gnu-ld
OBJCOPY=mipsel-linux-gnu-objcopy
OBJDUMP=mipsel-linux-gnu-objdump

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

# Step 1: Compile to MIPS32 LE assembly
$GCC -nostdlib -static -march=mips32 -mfp32 -O0 -S "$SRC_C" -o "$SRC_S"

# Step 2: Assemble
$AS -march=mips32 -o "$TMPDIR/app.o" "$SRC_S"

# Step 3: Link (set base address)
$LD -Ttext "$BASE_ADDR" -e main -o "$TMPDIR/app.elf" "$TMPDIR/app.o"

# Step 4: Convert to Big-endian 32-bit word stream
$OBJCOPY -O binary --reverse-bytes=4 \
         -j .text -j .data -j .rodata -j .init -j .MIPS.stubs \
         "$TMPDIR/app.elf" "$TMPDIR/app_be.bin"

# Step 5: Optional padding
if (( PAD_SIZE > 0 )); then
  dd if=/dev/zero bs=1 count=0 seek="$PAD_SIZE" \
     of="$TMPDIR/app_be.bin" conv=notrunc 2>/dev/null
fi

# Step 6: Dump to .mem (1 line per 32-bit word, big-endian)
xxd -p -c 4 "$TMPDIR/app_be.bin" > "$OUT_MEM"

# Step 7: Generate disassembly of raw binary for checking
$OBJDUMP -D -bbinary -m mips:isa32 -EB "$TMPDIR/app_be.bin" > "$OUT_DIS"

echo "[DONE] Outputs:"
echo "  - Assembly:     $SRC_S"
echo "  - Memory:       $OUT_MEM"
echo "  - Disassembly:  $OUT_DIS"
