# 🏥 MedCare Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![REST API](https://img.shields.io/badge/REST%20API-FF6C37?style=for-the-badge&logo=api&logoColor=white)]()

---

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

## 🧱 Project Structure

```
lib/
│
├── main.dart
│
├── Models/
│ ├── appointment_model.dart
│ ├── appointment_history_model.dart
│ ├── doctor_model.dart
│ ├── login_model.dart
│ ├── register_model.dart
│ ├── report_upload_model.dart
│ └── report_fetch_model.dart
│
├── Services/
│ └── api_services.dart # All HTTP logic (login, register, fetch, upload)
│
├── Utils/
│ └── token_storage.dart # SharedPreferences logic
│
├── Views/
│ ├── Auth/
│ │ ├── login_page.dart
│ │ └── register_page.dart
│ │
│ ├── Home/
│ │ └── home_page.dart
│ │
│ ├── Appointment/
│ │ ├── appointment_stepper.dart
│ │ ├── appointment_history_page.dart
│ │ └── Widgets/
│ │ ├── appointment_card.dart
│ │ └── doctor_card.dart
│ │
│ ├── Records/
│ │ ├── record_upload_dialog.dart
│ │ ├── record_list_page.dart
│ │ └── Widgets/
│ │ ├── dropdown_field_widget.dart
│ │ ├── description_field_widget.dart
│ │ └── dialog_button_widget.dart
│ │
│ └── Shared/
│ ├── header_widget.dart
│ ├── primary_button.dart
│ └── spacing_utils.dart
│
└── Constants/
└── app_colors.dart
└── strings.dart
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
