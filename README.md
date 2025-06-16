# 🏥 MedCare Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![REST API](https://img.shields.io/badge/REST%20API-FF6C37?style=for-the-badge&logo=api&logoColor=white)]()

---
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
  - `http` – For making API requests
  - `shared_preferences` – To store access/refresh tokens
  - `file_picker` – To pick PDF files from device storage
  - `path`, `path_provider` – For file management (if used)
  - `flutter/material.dart` – Flutter's core UI framework

### 🌐 Backend (Django)

- **Python**
- **Django** – Web framework
- **Django REST Framework (DRF)** – For building RESTful APIs
- **SimpleJWT** – Token-based authentication (JWT)
- **CORS Headers** – For cross-origin requests from Flutter
- **Model/File handling** – Handling file uploads and database storage

### 🗃️ Database

- **SQLite** (default for dev) or **PostgreSQL** (recommended for prod)

### 📡 API Communication

- REST APIs using:
  - `POST` for login, registration, uploading reports
  - `GET` for fetching appointments, reports, doctors

### 🔐 Authentication

- **JWT (JSON Web Tokens)**:
  - Access & Refresh tokens
  - Token stored in Flutter using `shared_preferences`

### 🧪 Testing/Debugging (Optional Tools)

- **Postman** – For API testing
- **Flutter DevTools** – Debugging Flutter UI and performance

---

## 🚀 Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/medcare_flutter.git
   cd medcare_flutter

   ```

2. Install dependencies:

```
    flutter pub get
```

3.  Connect your device/emulator and run:

        ```
        flutter run

        ```

    ⚠️ Make sure your backend Django server is running and accessible (update IPs in API URLs if needed).

# 🏥 MedCare App (Flutter + Django)

MedCare is a patient-focused healthcare app built with Flutter and Django. It allows users to register, log in, book medical appointments, and upload/view medical records in PDF format.

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



## 🛠️ Technologies Used

### Frontend

- **Flutter** (Dart)
   cupertino_icons: ^1.0.8
  file_picker: ^10.1.9
  image_picker: ^1.1.2
  logger: ^2.5.0
  http: ^1.4.0
  shared_preferences: ^2.5.3
  path: ^1.9.1
  url_launcher: ^6.3.1
  provider: ^6.1.5

## 📌 Future Improvements

- Edit/Delete uploaded reports
- Profile screen with patient data
- Doctor/admin role management
- Enhanced UI with PDF preview
- Appointment filtering and pagination

---

## 🚀 Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/medcare_flutter.git
   cd medcare_flutter

   ```

2. Install dependencies:

```
    flutter pub get
```

3.  Connect your device/emulator and run:

        ```
        flutter run

        ```

    ⚠️ Make sure your backend Django server is running and accessible (update IPs in API URLs if needed).
