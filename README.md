# ToDo App (Flutter) — Firebase template

This repository is a minimal Flutter app template for a ToDo application using **Firebase Auth** and **Cloud Firestore**.

**How this template works for Termux + Codemagic workflow**
- You can edit the Dart files directly on your Android device (Termux, editor).
- Push this repo to GitHub.
- On Codemagic, set an environment variable `GOOGLE_SERVICES_JSON` containing your `google-services.json` encoded as base64 (secure).
- Codemagic workflow runs `flutter create .` to generate `android/` and `ios/` platform folders, decodes `google-services.json`, runs `flutter pub get`, and builds APK/AAB.

## Quick steps

1. Edit code as needed.
2. Commit & push to GitHub.
3. In Codemagic app settings, add env var `GOOGLE_SERVICES_JSON` with base64 content of google-services.json.
4. Run build on Codemagic; artifacts appear in the Artifacts tab.

