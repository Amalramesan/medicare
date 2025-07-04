🏥 MedCare Flutter App




MedCare is a patient-centered healthcare mobile application built using Flutter and follows the MVVM (Model-View-ViewModel) architectural pattern.

✨ Key Features
👤 User Authentication
Secure registration and login via REST API.

Tokens are securely stored using SharedPreferences.

🗓️ Appointment Booking
Step-by-step booking flow:

Select appointment date

View available doctors

Pick a suitable time slot

Displays patient-specific appointment history.

API-driven scheduling and availability.

📄 Medical Records
Upload PDF reports:

Select report type (dropdown)

Add an optional description

Upload file via device file picker

Send data using multipart/form-data.

Fetch and view uploaded reports from the backend.

🧱 Architecture – MVVM Pattern
MedCare follows the MVVM (Model-View-ViewModel) pattern, enhancing:

Code maintainability

Separation of concerns

Testability

Scalability

🔁 MVVM Data Flow
sql
Copy
Edit
View ↔ ViewModel ↔ Repository ↔ Network/API
📁 MVVM Structure Overview
graphql
Copy
Edit
lib/
├── Models/         # Data models
├── repository/     # API logic per feature
├── view_model/     # ViewModel business logic
│   ├── controller/
│   └── services/
├── Views/          # UI (screens & widgets)
📂 Project Structure
csharp
Copy
Edit
lib/
├── main.dart
├── common/                     # Shared custom widgets
├── data/
│   ├── network/                # API service layer
│   └── response/               # API response & error handling
├── Models/                    # All data models
├── repository/                # API logic
├── res/                       # App-wide constants
├── routes/                    # App routing
├── Utils/                     # Token handling, validators, etc.
├── view_model/
│   ├── controller/            # ViewModels
│   └── services/
├── Views/                     # UI views organized by feature
│   ├── Appointment/
│   ├── Login/
│   ├── Registration/
│   ├── Records/
│   ├── Profile/
│   └── splash_screen.dart
🧰 Tech Stack
💻 Frontend
Flutter SDK – UI framework

Dart – Programming language

📦 Packages Used
cupertino_icons – iOS-style icons

file_picker – Pick files from device

image_picker – (Unused currently)

logger – For logging/debugging

http – For API calls

shared_preferences – Local storage (tokens/sessions)

path – File path utilities

url_launcher – Open URLs/files

provider – State management

http_parser – For MediaType in file uploads

📡 API Communication
POST: login, registration, report upload

GET: appointments, doctor list, uploaded reports

🔐 Authentication
JWT-based authentication

Access & Refresh tokens

Stored securely using shared_preferences

🧪 Testing (Optional)
Postman – For API testing and backend validation

🚀 Getting Started
1. Clone the repository
bash
Copy
Edit
git clone https://github.com/Amalramesan/medicare.git
cd medcare_flutter
2. Install dependencies
bash
Copy
Edit
flutter pub get
3. Run the app
bash
Copy
Edit
flutter run
📌 Notes
Ensure API URLs match your local IP and port (e.g., Django backend).

The app uses token-based authentication (Access + Refresh tokens).

If you change your backend URL, update res/app_url.dart.
