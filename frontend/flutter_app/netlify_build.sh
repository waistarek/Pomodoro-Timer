#!/usr/bin/env bash

set -e

git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$HOME/flutter"
export PATH="$PATH:$HOME/flutter/bin"

flutter doctor
flutter pub get
flutter build web --release \
  --dart-define=API_BASE_URL="${API_BASE_URL:-https://pomodoro-backend-00pe.onrender.com}" \
  --dart-define=GOOGLE_CLIENT_ID="${GOOGLE_CLIENT_ID:-}"