
# Time2Focus – Pomodoro Timer & Focus Tracking

**A productivity and focus-tracking application built with Flutter, Dart, Python, and FastAPI.**

**Live Web App:** [time2focus.app](https://time2focus.app/)

Time2Focus combines a configurable Pomodoro timer, task management, productivity statistics, user authentication, and local session storage with a REST API and a relational database.

The application supports both guest usage and authenticated user accounts. It includes local data persistence, offline session queuing, and synchronization mechanisms for completed focus sessions.

The primary application is developed with **Flutter Web**. An Android project is also included.

**Project Status:** Functionally implemented development project with automated tests for selected components. Complete production readiness, cross-platform reliability, and end-to-end functionality have not been independently verified.

---

## Features

### Pomodoro Timer

- Configurable focus sessions, short breaks, and long breaks.
- Start, pause, resume, reset, and skip-break controls.
- Automatic switching between focus and break phases.
- Optional automatic start of the next phase.
- Clock-based remaining-time calculation.
- Local timer state persistence and restoration logic.
- Optional completion sounds.
- Browser notifications where supported and permitted.
- Keyboard shortcuts for timer controls.

Timer restoration is implemented, but behavior across browser reloads, authenticated sessions, and multiple tabs requires additional integration testing.

### Task Management

- Create, edit, complete, and delete tasks.
- Organize tasks using descriptions, priorities, and tags.
- Select tasks for individual focus sessions.
- Associate completed Pomodoro sessions with tasks.
- Track task-related Pomodoro counts.
- Manage tasks through the Flutter interface and FastAPI backend.

### Productivity Statistics

- Weekly, monthly, and yearly statistics.
- Completed Pomodoro counts.
- Total focus time tracking.
- Task-specific productivity statistics.
- Focus streaks and best focus day calculations.
- Timezone-aware backend statistics.
- Visual representation of productivity data using charts.

Some statistics require an authenticated account. Guest statistics are currently more limited than those available to authenticated users.

### User Authentication

- Email and password registration.
- User login and account management.
- Email verification logic.
- Password reset functionality.
- Google Sign-In integration.
- GitHub OAuth integration.
- JWT-based API authentication.
- User-specific access to application data.

OAuth authentication and email delivery require correctly configured external services.

Linking multiple authentication providers to an existing account is not currently implemented.

### Guest Mode

Time2Focus can be used without creating an account.

Guest functionality includes:

- Using the Pomodoro timer.
- Managing supported local application data.
- Recording completed focus sessions locally.
- Accessing basic productivity information.
- Transferring locally stored sessions during login.

The guest mode provides access to core functionality without requiring immediate registration.

### Local Storage & Session Synchronization

- Local session storage using SharedPreferences.
- Offline queue for pending focus sessions.
- User-specific local storage keys.
- Transfer of locally completed guest sessions during login.
- Client-generated session identifiers.
- Duplicate-resistant session synchronization.
- Retry mechanisms for selected synchronization failures.

The backend enforces a unique constraint on the combination of user ID and client session ID.

This helps prevent duplicate session records when synchronization requests are repeated.

The application does not currently provide complete offline-first synchronization or conflict resolution for every data type.

### User Interface

- Responsive Flutter interface using Material 3.
- Light, dark, and system themes.
- Configurable theme colors.
- Provider-based state management.
- Navigation using go_router.
- Localization files for 15 languages.
- Public landing page with localized routes.
- Accessibility-related features, including semantic labels, tooltips, and keyboard support.

Translation coverage and accessibility compliance have not been fully audited.

---

## Tech Stack

### Frontend

| Technology | Purpose |
|------------|---------|
| Flutter | Cross-platform application framework |
| Dart | Application logic |
| Material 3 | User interface and themes |
| Provider / ChangeNotifier | Application state management |
| go_router | Navigation and routing |
| http | REST API communication |
| shared_preferences | Local data persistence |
| fl_chart | Productivity charts |
| audioplayers | Timer completion sounds |
| intl / flutter_localizations | Internationalization |
| google_sign_in | Google authentication integration |
| uuid | Client-side session identifiers |

### Backend

| Technology | Purpose |
|------------|---------|
| Python | Backend development |
| FastAPI | REST API framework |
| Pydantic | Request and response validation |
| SQLAlchemy | ORM and database access |
| Alembic | Database migrations |
| python-jose | JWT authentication |
| passlib / bcrypt | Password hashing |
| google-auth | Google ID token verification |
| requests | GitHub OAuth/API communication |
| Uvicorn | ASGI application server |
| pytest | Automated backend testing |

### Database & Infrastructure

| Technology | Purpose |
|------------|---------|
| SQLite | Local development database |
| PostgreSQL / psycopg | Database support and configuration |
| Netlify | Flutter Web deployment configuration |
| Render | Backend deployment documentation |
| GitHub Actions | Automated database migration workflow |
| Gradle | Android build system |

PostgreSQL support, migration tooling, and deployment configuration are present in the project. The current production database provider and deployment state have not been independently verified.

---

## Architecture

Time2Focus follows a separated frontend/backend architecture.

The Flutter application manages the user interface and local application state, while the FastAPI backend handles authentication, database operations, and server-side functionality.

```text
                    Time2Focus
                         |
                  Flutter Web App
                         |
                  Screens & Widgets
                         |
                Provider / ChangeNotifier
                         |
              +----------+----------+
              |                     |
              v                     v
        Local Storage          API Services
              |                     |
              v                     v
       SharedPreferences        HTTP / JSON
                                    |
                                    v
                              FastAPI Backend
                                    |
                  +-----------------+----------------+
                  |                 |                |
                  v                 v                v
            Authentication     Application       Statistics
                               Logic
                  |                 |
                  +--------+--------+
                           |
                           v
                      SQLAlchemy
                           |
                           v
                   Relational Database
```

### Frontend Architecture

The Flutter frontend is organized into separate application layers.

**Models**

Define the data structures used for tasks, focus sessions, settings, and statistics.

**Providers**

Manage application state and business logic using ChangeNotifier.

**Services**

Handle REST API communication, local persistence, authentication, notifications, and other external integrations.

**Screens**

Implement the different application views.

**Widgets**

Provide reusable interface components.

**Router**

Manages navigation and application routes.

**Timer Engine**

Implements the Pomodoro phase logic independently of the main user interface.

Important provider classes include:

- `AuthProvider`
- `TimerProvider`
- `TaskProvider`
- `SettingsProvider`
- `StatsProvider`
- `SessionSyncProvider`

### Backend Architecture

The FastAPI backend is responsible for:

- User registration and authentication.
- Authorization and user-specific data access.
- Task management.
- Focus session persistence.
- Duplicate-resistant session creation.
- User settings.
- Productivity statistics.
- Database interactions.

SQLAlchemy is used for database access, while Alembic manages database schema migrations.

### Timer State Management

The timer uses a dedicated timer engine and provider-based state management.

The implementation includes:

- Clock-based remaining-time calculations.
- Phase transitions.
- Start, pause, resume, and reset operations.
- Session completion handling.
- Client-generated session identifiers.
- Protection against duplicate session completion.
- Local timer state persistence.

These components separate the timing logic from the presentation layer.

### Session Synchronization & Idempotency

Completed focus sessions can be stored locally and later synchronized with the backend.

Each session receives a client-generated identifier:

```text
client_session_id
```

The backend uses a database uniqueness constraint on:

```text
(user_id, client_session_id)
```

This mechanism supports idempotent session creation by preventing multiple records with the same session identifier for the same user.

It is especially relevant when synchronization requests are retried after temporary connectivity problems.

---

## Project Structure

```text
Pomodoro-Timer/
|
|-- .github/
|   `-- workflows/
|       `-- migrate.yml
|
|-- backend/
|   |-- alembic/
|   |   `-- versions/
|   |-- app/
|   |   |-- main.py
|   |   |-- database.py
|   |   |-- deps.py
|   |   |-- models.py
|   |   |-- schemas.py
|   |   |-- security.py
|   |   |-- stats.py
|   |   `-- email_service.py
|   |-- tests/
|   |   `-- test_api.py
|   |-- alembic.ini
|   `-- requirements.txt
|
|-- frontend/
|   |-- flutter_app/
|   |   |-- android/
|   |   |-- assets/
|   |   |-- lib/
|   |   |   |-- config/
|   |   |   |-- l10n/
|   |   |   |-- models/
|   |   |   |-- providers/
|   |   |   |-- router/
|   |   |   |-- screens/
|   |   |   |-- services/
|   |   |   |-- timer/
|   |   |   |-- widgets/
|   |   |   `-- main.dart
|   |   |-- test/
|   |   |-- web/
|   |   |-- pubspec.yaml
|   |   `-- netlify_build.sh
|   `-- netlify.toml
|
|-- docs/
|-- scripts/
|-- NEXT_STEPS.md
`-- README.md
```

The Flutter application is located at:

```text
frontend/flutter_app/
```

The FastAPI application is located at:

```text
backend/app/
```

---

## Getting Started

The following instructions describe the documented local development setup.

A complete fresh-installation workflow has not been independently re-tested during this documentation review.

### Prerequisites

Make sure the following tools are installed:

- Git
- Python and pip
- Flutter SDK with Dart
- Google Chrome or another supported Flutter target

For Android development, an Android SDK and a configured device or emulator are also required.

The Flutter project declares Dart SDK compatibility with:

```text
>=3.4.0 <4.0.0
```

The exact Flutter SDK version required by the current dependency lockfile should be verified locally.

### 1. Clone the Repository

```bash
git clone https://github.com/waistarek/Pomodoro-Timer.git
cd Pomodoro-Timer
```

### 2. Set Up the Backend

Navigate to the backend directory:

```bash
cd backend
```

Create a Python virtual environment:

```bash
python -m venv .venv
```

Activate the virtual environment.

**Windows PowerShell:**

```powershell
.\.venv\Scripts\Activate.ps1
```

**Windows Git Bash:**

```bash
source .venv/Scripts/activate
```

**Linux / macOS:**

```bash
source .venv/bin/activate
```

Install the backend dependencies:

```bash
python -m pip install -r requirements.txt
```

### 3. Configure Environment Variables

The backend requires environment configuration for database access, authentication, and enabled external integrations.

If `backend/.env.example` is available, create a local `.env` file from it.

**Linux / macOS / Git Bash:**

```bash
cp .env.example .env
```

**Windows PowerShell:**

```powershell
Copy-Item .env.example .env
```

Otherwise, create a local `.env` file using the configuration requirements described below.

For local SQLite development, the project documentation includes:

```dotenv
DATABASE_URL=sqlite:///./pomodoro.db
```

Configure a secure JWT signing secret and the required frontend origins.

Additional credentials are needed when enabling Google OAuth, GitHub OAuth, or email delivery.

**Important:** Never commit `.env` files, authentication secrets, database credentials, or OAuth client secrets.

### 4. Configure the Database

The backend uses SQLAlchemy and Alembic for database management.

From the `backend/` directory, inspect the available migration heads:

```bash
alembic heads
```

Apply the migrations:

```bash
alembic upgrade head
```

The migration graph in the reviewed project contains one current head.

Applying all migrations to a newly created database has not been re-tested during this documentation review.

### 5. Start the Backend

From the `backend/` directory:

```bash
uvicorn app.main:app --reload
```

The documented local backend address is:

http://127.0.0.1:8000

Interactive API documentation:

http://127.0.0.1:8000/docs

Health endpoint:

http://127.0.0.1:8000/health

### 6. Install Flutter Dependencies

Open a second terminal in the repository root.

Navigate to the Flutter project:

```bash
cd frontend/flutter_app
```

Install the dependencies:

```bash
flutter pub get
```

### 7. Start Flutter Web

Run the application in Chrome:

```bash
flutter run -d chrome --web-port=8080 --dart-define=API_BASE_URL=http://127.0.0.1:8000
```

This example uses port `8080`, which is included in the documented local backend CORS configuration.

Ensure that the FastAPI backend is running before using features that require API access.

---

## Configuration

### Backend Environment Variables

The backend supports the following configuration variables:

| Variable | Purpose |
|----------|---------|
| `DATABASE_URL` | Database connection |
| `JWT_SECRET` | JWT signing secret |
| `JWT_ALGORITHM` | JWT algorithm |
| `ACCESS_TOKEN_EXPIRE_MINUTES` | Access token validity |
| `CORS_ORIGINS` | Allowed frontend origins |
| `GOOGLE_CLIENT_ID` | Google token verification |
| `GITHUB_CLIENT_ID` | GitHub OAuth client ID |
| `GITHUB_CLIENT_SECRET` | GitHub OAuth client secret |
| `FRONTEND_URL` | Frontend URL for redirects |
| `PUBLIC_BACKEND_URL` | Public backend URL |
| `SMTP_HOST` | Email server |
| `SMTP_PORT` | Email server port |
| `SMTP_USER` | Email authentication username |
| `SMTP_PASSWORD` | Email authentication password |
| `SMTP_FROM` | Email sender address |

Not all external-service variables are required for basic guest usage.

Email and OAuth features require the corresponding services to be configured.

### Flutter Build-Time Configuration

The Flutter frontend uses Dart environment definitions:

| Variable | Purpose |
|----------|---------|
| `API_BASE_URL` | FastAPI backend address |
| `GOOGLE_CLIENT_ID` | Public Google OAuth client ID |
| `GITHUB_CLIENT_ID` | Public GitHub OAuth client ID |

These values can be supplied using `--dart-define`.

OAuth client secrets must remain on the backend and must never be included in Flutter builds.

---

## Using Time2Focus

You can access the application's public website at:

**[https://time2focus.app/](https://time2focus.app/)**

### Guest Usage

1. Open the web application.
2. Navigate to the timer.
3. Configure the focus and break durations.
4. Optionally select or manage a task.
5. Start a focus session.
6. Pause, resume, or reset when needed.
7. Complete the session.
8. Review the locally available statistics.

Guest usage does not require registration.

### Authenticated Usage

Authenticated users can additionally work with backend-backed application features.

These include:

- User-specific tasks.
- Stored focus sessions.
- Application settings.
- Extended productivity statistics.
- Synchronization of completed sessions.

### Main Application Routes

The frontend includes the following routes:

```text
/
    Public landing page

/timer
    Pomodoro timer

/tasks
    Task management

/statistics
    Productivity statistics

/settings
    Application settings

/account
    User account
```

Password reset functionality is available under:

```text
/reset-password
```

---

## REST API

The FastAPI backend provides endpoints for the application's core functionality.

### Authentication

Endpoints under:

```text
/auth/*
```

Support registration, login, authentication, OAuth integration, email verification, and password reset workflows.

### User Management

```text
/users/me
```

Provides access to the authenticated user's information.

### Task Management

```text
/tasks
```

Supports task-related operations.

### Focus Sessions

```text
/sessions
```

Handles session storage and retrieval.

### Productivity Statistics

```text
/stats/*
```

Provides statistics for different periods and task-related analyses.

### Settings

```text
/settings
```

Handles application settings.

### Health Check

```text
/health
```

Provides a backend health-check endpoint.

FastAPI automatically generates interactive OpenAPI documentation at:

```text
http://127.0.0.1:8000/docs
```

---

## Testing

The repository includes automated backend tests and Flutter tests.

### Backend Tests

The backend test file is located at:

```text
backend/tests/test_api.py
```

The reviewed test suite contains 13 test functions covering selected aspects of:

- Registration and login.
- User access.
- Task management.
- Session persistence.
- Productivity statistics.
- Task-related statistics.
- Duplicate-resistant session creation.
- Timezone handling.
- Settings persistence.
- Email verification.
- Google OAuth behavior using mocks.

Run the backend tests from the `backend/` directory:

```bash
python -m pytest -q
```

### Flutter Tests

The Flutter project includes:

```text
test/timer_engine_test.dart
test/widget_test.dart
```

The reviewed tests cover:

- Pomodoro phase logic.
- Time formatting.
- Timer reset.
- Break skipping.
- Selected widget behavior.
- Semantic accessibility labels.

Run the tests from `frontend/flutter_app/`:

```bash
flutter test
```

### Flutter Static Analysis

Run:

```bash
flutter analyze
```

### Testing Status

Automated tests are implemented, but the latest complete test run has not been independently confirmed.

Additional integration, browser end-to-end, and deployment tests remain necessary for comprehensive quality assurance.

---

## Building the Application

### Flutter Web

From `frontend/flutter_app/`:

```bash
flutter build web --release --dart-define=API_BASE_URL=https://your-backend.example.com
```

Replace the example backend URL with the appropriate backend endpoint.

The generated build files are located under:

```text
build/web/
```

### Android

An Android project is included in the repository.

Build an Android APK using:

```bash
flutter build apk --release --dart-define=API_BASE_URL=https://your-backend.example.com
```

An Android APK build was previously completed during development.

However, the reviewed Android configuration still contains a placeholder application ID and debug signing for release builds.

These settings require further configuration before a production store release.

### iOS

An iOS platform project was not present in the reviewed repository archive.

Therefore, iOS support should be considered a future development option rather than an existing release target.

---

## Deployment

**Web Application:** [https://time2focus.app/](https://time2focus.app/)

The repository includes configuration and documentation for:

- Flutter Web hosting with Netlify.
- FastAPI backend hosting with Render.
- Database schema migrations using Alembic.
- GitHub Actions migration workflows.
- PostgreSQL connectivity and Neon-oriented migration configuration.

Relevant project files include:

```text
frontend/netlify.toml
frontend/flutter_app/netlify.toml
frontend/flutter_app/netlify_build.sh
.github/workflows/migrate.yml
docs/deployment/
```

The public web address is provided as the project demonstration link.

The current availability of backend services, OAuth integrations, email delivery, and database infrastructure has not been independently verified during this documentation review.

---

## Technical Highlights

Time2Focus demonstrates the implementation of several software engineering concepts.

### Full-Stack Development

Development of a Flutter frontend and a separate Python/FastAPI backend connected through REST APIs.

### State Management

Use of Provider and ChangeNotifier to separate user interface components from application state and business logic.

### Timer Engine Design

Implementation of a dedicated timer engine for phase transitions, duration handling, and focus session completion.

### Persistent Data Storage

Combination of local SharedPreferences storage and backend database persistence.

### Database Design & Migrations

Relational database models using SQLAlchemy and schema migration management with Alembic.

### Authentication & Authorization

Implementation of JWT authentication, password hashing, OAuth integrations, and user-specific data access.

### Idempotent Session Processing

Use of client-generated session IDs and database uniqueness constraints to reduce duplicate session creation during repeated synchronization requests.

### Internationalization

Use of Flutter localization files and language-specific application routes.

### Automated Testing

Backend API tests and Flutter unit and widget tests covering selected application functionality.

---

## Known Limitations

Time2Focus is an actively developed software project and should not be considered a fully production-hardened application.

Known limitations include:

- Offline synchronization is currently focused primarily on completed sessions.
- General task and settings synchronization does not provide full offline conflict resolution.
- Timer restoration across authenticated sessions and browser reloads requires additional testing.
- Browser notifications are implemented, but native Android notifications are not.
- The vibration setting does not have a verified device-vibration implementation.
- Guest statistics are more limited than authenticated user statistics.
- Some interface messages remain untranslated.
- Complete accessibility testing has not been performed.
- Android store release configuration is not finalized.
- An iOS platform project is not included.
- Comprehensive end-to-end and cross-browser testing remains incomplete.
- Production deployment and external authentication workflows require further verification.

---

## Future Improvements

Potential future development areas include:

- Expanded integration and end-to-end testing.
- Improved session synchronization and error recovery.
- More reliable timer restoration across browser reloads and account changes.
- Complete internationalization coverage.
- Extended accessibility testing.
- Native Android notifications.
- Device vibration support.
- More comprehensive offline synchronization for tasks and settings.
- Finalized Android release configuration.
- Verified application screenshots and demos.
- Updated deployment documentation.
- Additional automated quality checks.

These improvements are planned or possible extensions and are not presented as existing functionality.

---

## Development Background

Time2Focus started as a simple Pomodoro timer implemented with HTML, CSS, and JavaScript.

The original version provided a basic focus timer with start, pause, reset, and sound functionality.

The project was subsequently developed into a more extensive application using Flutter and FastAPI.

The development has involved:

- Frontend application architecture.
- State management.
- REST API design.
- Relational database modeling.
- Authentication and authorization.
- Local data persistence.
- Focus session synchronization.
- Productivity statistics.
- Internationalization.
- Responsive user interface development.
- Automated testing.
- Deployment configuration.

The project represents practical work across multiple layers of application development, from frontend interaction and state management to backend services and database persistence.

---

## Additional Documentation

Further technical information is available in the repository:

- [Architecture Documentation](docs/architecture.md)
- [Original Project Analysis](docs/original-project-analysis.md)
- [Deployment Documentation](docs/deployment/)
- [Next Steps](NEXT_STEPS.md)

---

**Time2Focus – Focus on what matters.**
