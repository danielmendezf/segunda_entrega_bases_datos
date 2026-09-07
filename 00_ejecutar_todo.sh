#!/usr/bin/env bash
# ============================================================
# Script 00: Ejecución automática de los 6 scripts SQLite
# ============================================================
# Uso:
#   ./00_ejecutar_todo.sh              -> usa constructora.db
#   ./00_ejecutar_todo.sh otra.db      -> usa la base indicada
#
# Ejecuta los scripts en orden (01 DDL -> 06 vista) y se
# detiene ante el primer error. El script 01 recrea el esquema,
# por lo que la base queda con datos frescos al terminar.
# ============================================================
set -euo pipefail

DB="${1:-constructora.db}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

for script in 0{1..6}_*.sql; do
    echo "==> Ejecutando $script sobre '$DB'..."
    sqlite3 -header -column "$DB" ".read $script"
    echo
done

echo "Listo: los 6 scripts se ejecutaron correctamente sobre '$DB'."
