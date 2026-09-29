#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# hot.sh — drive an already-running `flutter run` from any shell.
#
# Setup (done once per session):
#   ./scripts/hot.sh start          # launches flutter run for emulator-5554
#                                   # (or whatever device you pass as $2)
#
# After the app is up, trigger:
#   ./scripts/hot.sh r              # hot reload  (preserves app state)
#   ./scripts/hot.sh R              # hot restart (resets app state)
#   ./scripts/hot.sh q              # quit flutter run
#   ./scripts/hot.sh status         # show whether flutter run is alive
#   ./scripts/hot.sh logs           # tail flutter_run.log
#   ./scripts/hot.sh watch [dir]    # auto hot-reload on .dart save (needs fswatch)
#
# How it works:
#   - /tmp/flutter_stdin is a named pipe (FIFO) used as flutter run's stdin
#   - A `sleep infinity` writer is kept open so the FIFO never sees EOF
#   - `echo r > /tmp/flutter_stdin` sends keystrokes flutter would normally
#     read from your interactive terminal
# ---------------------------------------------------------------------------

set -euo pipefail

PIPE="/tmp/flutter_stdin"
LOG="/tmp/flutter_run.log"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cmd="${1:-help}"

flutter_pid() {
  pgrep -f "flutter_tools.*run -d " | head -1 || true
}

writer_pid() {
  pgrep -f "sleep infinity" | head -1 || true
}

case "$cmd" in
  start)
    device="${2:-emulator-5554}"

    # Kill any existing flutter run and writer-keeper
    [[ -n "$(flutter_pid)" ]] && kill -INT "$(flutter_pid)" 2>/dev/null || true
    [[ -n "$(writer_pid)" ]] && kill "$(writer_pid)" 2>/dev/null || true
    sleep 1

    # (Re)create FIFO
    rm -f "$PIPE"
    mkfifo "$PIPE"

    # Keep a writer open so flutter never sees EOF on stdin
    nohup sleep infinity > "$PIPE" 2>/dev/null &
    echo "writer-keeper PID $!"

    cd "$PROJECT_DIR"
    nohup flutter run -d "$device" < "$PIPE" > "$LOG" 2>&1 &
    echo "flutter run PID $!"
    echo "Logs: $LOG"
    echo "When you see 'Flutter run key commands' in logs, hot reload is ready."
    ;;

  r|reload)
    [[ -p "$PIPE" ]] || { echo "FIFO not set up. Run: $0 start"; exit 1; }
    echo r > "$PIPE"
    echo "Hot reload sent."
    ;;

  R|restart)
    [[ -p "$PIPE" ]] || { echo "FIFO not set up. Run: $0 start"; exit 1; }
    echo R > "$PIPE"
    echo "Hot restart sent."
    ;;

  q|quit)
    [[ -p "$PIPE" ]] || { echo "FIFO not set up."; exit 1; }
    echo q > "$PIPE"
    sleep 1
    [[ -n "$(writer_pid)" ]] && kill "$(writer_pid)" 2>/dev/null || true
    rm -f "$PIPE"
    echo "Quit sent and FIFO removed."
    ;;

  status)
    fpid="$(flutter_pid)"
    wpid="$(writer_pid)"
    [[ -p "$PIPE" ]] && echo "FIFO:           present" || echo "FIFO:           missing"
    [[ -n "$wpid"  ]] && echo "writer-keeper:  PID $wpid" || echo "writer-keeper:  not running"
    [[ -n "$fpid"  ]] && echo "flutter run:    PID $fpid" || echo "flutter run:    not running"
    ;;

  logs)
    tail -n 40 -f "$LOG"
    ;;

  watch)
    dir="${2:-$PROJECT_DIR/lib}"
    command -v fswatch >/dev/null || { echo "Install fswatch: brew install fswatch"; exit 1; }
    [[ -p "$PIPE" ]] || { echo "FIFO not set up. Run: $0 start"; exit 1; }
    echo "Watching $dir for .dart changes — Ctrl-C to stop"
    fswatch -o -e ".*" -i "\\.dart$" "$dir" | while read -r _; do
      echo "[$(date +%H:%M:%S)] change detected, hot reloading"
      echo r > "$PIPE"
    done
    ;;

  help|*)
    sed -n '2,/^# ---/p' "$0" | sed 's/^# \?//'
    ;;
esac
