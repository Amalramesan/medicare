🏥 MedCare Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![REST API](https://img.shields.io/badge/REST%20API-FF6C37?style=for-the-badge&logo=api&logoColor=white)]()

MedCare is a patient-centered healthcare mobile app built with Flutter and structured using the MVVM (Model-View-ViewModel) architectural pattern.

It allows patients to:

Register and log in

Book medical appointments

Upload and view medical reports (PDF)

View appointment history

📲 Features
👤 User Authentication
User registration and login using REST APIs

Stores tokens securely using SharedPreferences

🗓️ Appointment Booking
Stepper-based booking flow:

Select date

View only available doctors

Pick a time slot

Uses API to fetch doctor availability and book appointments

Displays appointment history by patient

📄 Medical Records
Upload PDF reports with:

Dropdown for report type

Optional description

File picker

Send via multipart/form-data API request

Fetch and display uploaded reports from the backend

🧱 Architecture – MVVM Pattern
This project uses the Model-View-ViewModel (MVVM) pattern to separate business logic, API handling, and UI. This improves code scalability, testability, and maintenance.

📂 MVVM Overview
graphql
Copy
Edit
lib/
├── Models/ # Data models (Appointment, Doctor, Reports, etc.)
├── repository/ # Handles API communication per feature
├── view_model/
│ ├── controller/ # Business logic (ViewModels)
│ └── services/ # Shared services (e.g., token storage, validators)
├── Views/ # UI layer (views + widgets)
🔁 Data Flow in MVVM:
View (UI) interacts with the ViewModel (controller/)

ViewModel calls the appropriate repository to fetch/update data

Data is returned to the ViewModel, which notifies the View

📂 Project Structure

lib/
│
├── main.dart
│
├── common/ ← Optional (can delete if contents moved to res/)
│ └── custom_text_field.dart
│
├── data/
│ ├── network/
│ │ ├── base_api_service.dart
│ │ └── network_api_service.dart
│ │
│ └── response/
│ ├── api_response.dart
│ ├── app_exception.dart
│ └── status.dart
│
├── Models/
│ ├── appointment_model.dart
│ ├── appointment_history_model.dart
│ ├── doctor_model.dart
│ ├── login_model.dart
│ ├── register_model.dart
│ ├── report_upload_model.dart
│ ├── date_model.dart
│ ├── doctor_availability_model.dart
│ ├── time_slot_model.dart
│ └── report_fetch_model.dart
│
├── repository/
│ ├── appointment_repository.dart
│ ├── auth_repository.dart
│ ├── doctor_repository.dart
│ ├── documents_repository.dart
│ ├── logout_repository.dart
│ ├── profile_repository.dart
│ └── timeslot_repository.dart
│
├── res/
│ ├── app_url.dart
│ └── custom_text_field.dart ← moved from `common/`
│
├── routes/
│ └── app_routes.dart
│
├── Utils/
│ ├── validator/
│ ├── clipper/
│ ├── all_slots.dart
│ └── token_storage.dart
│
├── view_model/
│ ├── controller/
│ │ ├── appointment_booking_controller.dart
│ │ ├── appointment_history_controller.dart
│ │ ├── bottomnav_controller.dart
│ │ ├── login_controller.dart
│ │ ├── profile_controller.dart
│ │ ├── register_controller.dart
│ │ ├── report_fetch_controller.dart
│ │ └── upload_controller.dart
│ │
│ └── services/
│ ├── store_auth_details.dart
│ └── validators.dart
│
├── Views/
│ ├── Appointment/
│ │ ├── widget/
│ │ │ ├── appointment_card.dart
│ │ │ ├── appointment_booking_dialog_widget.dart
│ │ │ ├── appointment_history.dart
│ │ │ ├── appointment_widget.dart
│ │ │ ├── book_appointment_button_widget.dart
│ │ │ ├── custom_appbar_widget.dart
│ │ │ ├── custom_button_nav_widget.dart
│ │ │ ├── dialog_date_widget.dart
│ │ │ ├── dialog_doctor_widget.dart
│ │ │ ├── dialog_timeslot_widget.dart
│ │ │ ├── greeting_widget.dart
│ │ │ ├── home_content_widget.dart
│ │ │ └── upcoming_appointment_title_widget.dart
│ │ └── appointment_view.dart
│ │
│ ├── Login/
│ │ ├── widget/
│ │ │ ├── login_button_widget.dart
│ │ │ ├── login_form_widget.dart
│ │ │ ├── login_header_widget.dart
│ │ │ ├── login_signup_button_widget.dart
│ │ │ └── login_widget.dart
│ │ └── login_view.dart
│ │
│ ├── Registration/
│ │ ├── widget/
│ │ │ ├── gender_and_age_widget.dart
│ │ │ ├── registration_button_widget.dart
│ │ │ ├── registration_form_widget.dart
│ │ │ ├── registration_header_widget.dart
│ │ │ ├── registration_widget.dart
│ │ │ └── spacing_helper_widget.dart
│ │ └── registration_view.dart
│ │
│ ├── Records/
│ │ ├── widget/
│ │ │ ├── description_record_field.dart
│ │ │ ├── dialog_button_widget.dart
│ │ │ ├── drop_down_file_widget.dart
│ │ │ ├── file_picker_button.dart
│ │ │ ├── record_widget.dart
│ │ │ ├── record_appbar_widget.dart
│ │ │ ├── upload_documents_widget.dart
│ │ │ ├── upload_form_widget.dart
│ │ │ └── record_list_widget.dart
│ │ └── record_view.dart
│ │
│ ├── Profile/
│ │ ├── widget/
│ │ │ ├── profile_textfield.dart
│ │ │ └── profile_widget.dart
│ │ └── profile_view.dart
│ │
│ └── splash_screen.dart

</details>
🧰 Tech Stack
💻 Frontend (Flutter)
Flutter SDK – Cross-platform UI toolkit

Dart – Programming language for Flutter

📦 Packages Used
cupertino_icons – iOS-style icons

file_picker – Pick PDF and other files from device storage

image_picker – (Unused for now)

logger – Debug logs

http – API calls

shared_preferences – Local token and session storage

path – File path utilities

url_launcher – Open URLs or files

provider – State management

http_parser – Set correct content type for uploads

📡 API Communication
POST for login, registration, uploading reports

GET for appointments, reports, doctor lists

🔐 Authentication
JWT Tokens: access + refresh tokens

Stored securely in app with shared_preferences

🧪 Testing (Optional)
Postman – Used to test backend APIs

🚀 Getting Started
Clone the repository:

bash
Copy
Edit
git clone https://github.com/Amalramesan/medicare.git
cd medcare_flutter
Install dependencies:

bash
Copy
Edit
flutter pub get
Run the app:

bash
Copy
Edit
flutter run
📌 Notes
Make sure your backend API URLs match your local IP and port (used by Django backend)

The app uses token-based authentication (access + refresh)
