#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../frontend/flutter_app"
flutter create --platforms=android,ios,web .
flutter pub get
