# Food For Health 🥗

A Flutter mobile app that helps people make safer food choices based on their health
conditions. Users scan a product's barcode, and the app combines the product's
ingredients with the user's chronic conditions to tell them — with the help of generative
AI — whether the product is suitable for them, along with a short explanation.

> 🔌 Backend (ASP.NET Core API): **[FoodForHealthAPI](https://github.com/YusufUguz/FoodForHealthAPI)**

---

## What it does

- **Account & session** — register and log in with a phone number; the JWT returned by the
  API is stored securely and decoded to keep the user signed in across launches.
- **Health profile** — users record physical information (height, weight, gender, birth
  date) and their chronic conditions.
- **Barcode scanning** — scan any product barcode with the device camera.
- **AI food evaluation** — the scanned product's ingredients and the user's conditions are
  sent to Google's Gemini model, which returns a clear suitable / not-suitable verdict and
  a short health note.
- **AI chat** — a built-in assistant for general nutrition and health questions.

## Tech stack

- **Flutter** (Dart, SDK 3.6+)
- **flutter_bloc** — Cubit-based state management
- **google_generative_ai** — Gemini integration for evaluation and chat
- **qr_code_scanner** — barcode/QR scanning
- **http** — REST communication with the backend
- **flutter_secure_storage** + **jwt_decoder** — secure token storage and session handling
- **convex_bottom_bar**, **quickalert**, **flutter_markdown**, **font_awesome_flutter**,
  **intl** — UI and formatting

## Architecture

The project follows a **feature-first** structure with a shared `core` layer, and uses the
**Cubit** pattern (view / view_model separation) for state management.

```
lib/
├── core/                     # Shared building blocks
│   ├── constants/            # API config, colors, prompts, app info
│   ├── general_functions/    # Reusable helpers
│   ├── general_widgets/      # Shared widgets, validators, storage/JWT helpers
│   └── models/               # Data models
└── features/                 # Self-contained features
    ├── splash/
    ├── login/
    ├── register/
    ├── bottom_nav_bar/
    ├── barcode_scan/
    ├── food_evaluation/      # view + view_model (Cubit) + state
    ├── chat_with_ai/
    └── profile/
```

Each feature keeps its UI (`view`) separate from its logic (`view_model`), and screens that
have non-trivial state expose a Cubit with an explicit `state` class.

## Engineering highlights

- **Feature-first structure** — each screen is a self-contained feature with its own view,
  view-model and state, which keeps the codebase easy to navigate and extend.
- **Single networking layer** — all REST calls go through one `ApiService` (`core/services`)
  that centralizes the base URL, JSON headers, the JWT bearer token and a shared timeout, so
  feature view-models stay focused on their own logic instead of repeating HTTP wiring.
- **Reusable widgets** — shared UI pieces (text fields, validators, buttons, cards, alerts)
  live in `core/general_widgets` and are composed across features to avoid duplication.
- **Predictable state** — Cubits emit explicit loading / loaded / error states, giving the UI
  a single source of truth to react to.
- **Secure session handling** — the JWT and cached user are stored with
  `flutter_secure_storage`, and the token is attached automatically to every authenticated
  request.

## Screenshots

> _Add a few screenshots or a short demo GIF here to showcase the UI._

| Login | Barcode scan | AI evaluation | Profile |
|-------|--------------|---------------|---------|
|       |              |               |         |

## Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.6 or newer)
- A running instance of the [Food For Health API](https://github.com/YusufUguz/FoodForHealthAPI)
- A [Google AI Studio](https://aistudio.google.com/app/apikey) API key for the Gemini features

### Configuration

Open `lib/core/constants/api_constants.dart` and set the two values:

```dart
// API base URL.
// - Android emulator:  http://10.0.2.2:<port>
// - iOS simulator:     http://localhost:<port>
// - Physical device:   http://<your-computer-LAN-IP>:<port>
static const String apiBaseUrl = "http://10.0.2.2:5016";

// Your Google AI Studio (Gemini) API key.
static const String geminiAPIKey = "";
```

> Android blocks plain HTTP (cleartext) traffic by default. For local development against an
> HTTP API, `usesCleartextTraffic` is enabled in the Android manifest.

### Run

```bash
flutter pub get
flutter run
```

## License

Released under the [MIT License](LICENSE).
