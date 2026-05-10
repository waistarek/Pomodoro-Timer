#!/usr/bin/env bash

set -e

git clone https://github.com/flutter/flutter.git -b stable --depth 1 $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

flutter doctor
flutter pub get
flutter build web --release --release --dart-define=API_BASE_URL=http://127.0.0.1:8000
