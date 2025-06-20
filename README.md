# 🏥 MedCare Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![REST API](https://img.shields.io/badge/REST%20API-FF6C37?style=for-the-badge&logo=api&logoColor=white)]()

---
<<<<<<< HEAD

**MedCare** is a patient-centered healthcare mobile app built with **Flutter**. It allows patients to:

=======
**MedCare** is a patient-centered healthcare mobile app built with **Flutter**. It allows patients to:
- Register and log in
- Book medical appointments
- Upload and view medical reports (PDF)
- View appointment history

---

## 📲 Features

### 👤 User Authentication

- User **registration** and **login** using REST APIs.
- Stores tokens securely using `SharedPreferences`.

### 🗓️ Appointment Booking

- **Stepper-based booking** flow:
  1. Select date.
  2. View only **available doctors**.
  3. Pick a time slot.
- Uses API to **fetch doctor availability** and **book appointments**.
- Displays **appointment history** by patient.

### 📄 Medical Records

- Upload **PDF reports** with:
  - Dropdown for report type.
  - Optional description.
  - File picker.
- Send via `multipart/form-data` API request.
- Fetch and display uploaded reports from the backend.

---

## 🧱 Project Structure

```
lib/
│
├── main.dart
│
├── common/
│   └── custom_text_field.dart
│
├── controller/
│   ├── login_controller.dart
│   └── register_controller.dart
│
├── Models/
│   ├── appointment_model.dart
│   ├── appointment_history_model.dart
│   ├── doctor_model.dart
│   ├── login_model.dart
│   ├── register_model.dart
│   ├── report_upload_model.dart
│   ├── date_model.dart
│   ├── doctor_availability_model.dart
│   ├── time_slot_model.dart
│   └── report_fetch_model.dart
│
├── routes/
│   └── app_routes.dart
│
├── Services/
│   └── api_services.dart
│
├── Utils/
│   ├── validator/
│   ├── clipper/
│   ├── all_slots.dart
│   └── token_storage.dart
│
├── Views/
│   ├── Appointment/
│   │   ├── widget/
│   │   │   ├── appointment_card.dart
│   │   │   ├── appointment_booking_dialog_widget.dart
│   │   │   ├── appointment_history.dart
│   │   │   ├── appointment_widget.dart
│   │   │   ├── book_appointment_button_widget.dart
│   │   │   ├── custom_appbar_widget.dart
│   │   │   ├── custom_button_nav_widget.dart
│   │   │   ├── dialog_date_widget.dart
│   │   │   ├── dialog_doctor_widget.dart
│   │   │   ├── dialog_timeslot_widget.dart
│   │   │   ├── greeting_widget.dart
│   │   │   ├── home_content_widget.dart
│   │   │   └── upcoming_appointment_title_widget.dart
│   │   └── appointment_view.dart
│   │
│   ├── Login/
│   │   ├── widget/
│   │   │   ├── login_button_widget.dart
│   │   │   ├── login_form_widget.dart
│   │   │   ├── login_header_widget.dart
│   │   │   ├── login_signup_button_widget.dart
│   │   │   └── login_widget.dart
│   │   └── login_view.dart
│   │
│   ├── Registration/
│   │   ├── widget/
│   │   │   ├── gender_and_age_widget.dart
│   │   │   ├── registration_button_widget.dart
│   │   │   ├── registration_form_widget.dart
│   │   │   ├── registration_header_widget.dart
│   │   │   ├── registration_widget.dart
│   │   │   └── spacing_helper_widget.dart
│   │   └── registration_view.dart
│   │
│   ├── Records/
│   │   ├── widget/
│   │   │   ├── description_record_field.dart
│   │   │   ├── dialog_button_widget.dart
│   │   │   ├── drop_down_file_widget.dart
│   │   │   ├── file_picker_button.dart
│   │   │   ├── record_widget.dart
│   │   │   ├── record_appbar_widget.dart
│   │   │   ├── upload_documents_widget.dart
│   │   │   ├── upload_form_widget.dart
│   │   │   └── record_list_widget.dart
│   │   └── record_view.dart
│   │
│   ├── Profile/
│   │   ├── widget/
│   │   │   ├── profile_textfield.dart
│   │   │   └── profile_widget.dart
│   │   └── profile_view.dart
│   │
│   └── splash_screen.dart

```

---

## 🧰 Tech Stack

### 💻 Frontend (Flutter)

- **Flutter SDK** – Cross-platform UI toolkit
- **Dart** – Programming language for Flutter
- **Packages Used:**
- cupertino_icons:OS-style icons support
- file_picker:Pick PDF and other files from storage
- image_picker:Image selection (currently unused in PDF workflow)
- logger:Debug-friendly logging for development
- http:HTTP client for REST API calls
- shared_preferences:Store authentication tokens and user session locally
- path:File path operations (used with file pickers or file handling)
- url_launcher:Open URLs or files (e.g., opening uploaded PDF)
- provider:State management (used to pass data between widgets and handle app state)
- http_parser:Helps in defining MediaType for file uploads (like application/pdf)


### 📡 API Communication

- REST APIs using:
  - `POST` for login, registration, uploading reports
  - `GET` for fetching appointments, reports, doctors

### 🔐 Authentication

- **JWT (JSON Web Tokens)**:
  - Access & Refresh tokens
  - Token stored in Flutter using `shared_preferences`

### 🧪 Testing (Optional Tools)
- **Postman** – For API testing

---

## 🚀 Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/Amalramesan/medicare.git
   cd medcare_flutter

   ```

2. Install dependencies:

```
    flutter pub get
```

3.  Connect your device/emulator and run:

            ```
            flutter run

    📌 Notes

- Ensure the backend API URLs match the local IP and port used in your Django project.
- The app uses token-based authentication (access + refresh tokens).
=======
        ```
📌 Notes
- Ensure the backend API URLs match the local IP and port used in your Django project.
- The app uses token-based authentication (access + refresh tokens).

