# AGENTS.md

## Project

- Flutter admin client for an attendance system (`attendance_system_admin`), Dart SDK `^3.11.5` (Flutter 3.41.x stable).
- Committed targets: Android, iOS, web, Windows.
- Early-stage scaffold: no backend, auth, routing, state management, persistence, assets, or codegen. Only `google_fonts`, `ionicons`, and `cupertino_icons` are added. Do not assume infrastructure that is not there.

## Commands

- `flutter pub get`
- `dart format lib test`
- `flutter analyze` (stock `flutter_lints`; no customized rules)
- `flutter test`; single file: `flutter test test/login_screen_test.dart`; single test: `flutter test test/login_screen_test.dart --plain-name "renders the login form actions"`
- `flutter run -d windows` (desktop target is configured in `.vscode/settings.json`), or `-d chrome`, or a connected Android/iOS device.
- Verification order: format -> analyze -> test.

## Testing policy

- Do not add or modify tests unless the user explicitly asks.
- Running the existing test suite during verification is still expected.

## Structure and conventions

- `lib/main.dart`: `MyApp` wires `AppTheme.light` and `home: LoginScreen`. There is no router or navigation layer yet.
- `lib/core/app_colors.dart`: `AppColors` static-const palette. Use it instead of raw hex values.
- `lib/core/app_theme.dart`: global `ThemeData` with Open Sans via `google_fonts`. The seed color is `deepPurple`, which does not match the brand palette; set brand colors explicitly with `AppColors`.
- Screens live flat in `lib/` (`login_screen.dart`); screen-local widgets stay in the screen file rather than a separate widgets directory. `LoginScreen` is stateful; helper widgets are private classes in the same file.
- `test/widget_test.dart` is only a smoke test. `test/login_screen_test.dart` covers the form, password visibility, and 320/390/1456 layouts.

## Gotchas

- Sign-in and forgot-password callbacks are intentionally no-ops: there is no auth/backend. Do not wire fake services without a requirement.
- The UI uses Material icons only; there are no image/SVG assets and no SVG dependency.
- Widget tests use the Ahem font, which renders every glyph as a full-width block. Keep labels in flexible/scrollable rows or the narrow-width layout test will report overflows.
- `windows/flutter/generated_plugin*`, `android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java`, and `ios/Runner/GeneratedPluginRegistrant.*` are generated. Never hand-edit; regenerate through Flutter tooling / `flutter pub get`.
- No CI, migrations, codegen, environment files, or custom test prerequisites exist. Do not invent extra setup steps.
