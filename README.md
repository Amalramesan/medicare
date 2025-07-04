# 🏥 MedCare Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![REST API](https://img.shields.io/badge/REST%20API-FF6C37?style=for-the-badge&logo=api&logoColor=white)]()

**MedCare** is a patient-centered healthcare mobile application built using **Flutter** and follows the **MVVM (Model-View-ViewModel)** architectural pattern.

---

## ✨ Key Features

### 👤 User Authentication
- Secure **registration** and **login** via REST API.
- Tokens are securely stored using `SharedPreferences`.

### 🗓️ Appointment Booking
- Step-by-step booking flow:
  1. Select appointment date
  2. View available doctors
  3. Pick a suitable time slot
- Displays patient-specific **appointment history**.
- API-driven scheduling and availability.

### 📄 Medical Records
- Upload **PDF reports**:
  - Select report type (dropdown)
  - Add an optional description
  - Upload file via device file picker
- Send data using `multipart/form-data`.
- Fetch and view uploaded reports from the backend.

---

## 🧱 Architecture – MVVM Pattern

MedCare follows the **MVVM (Model-View-ViewModel)** pattern, enhancing:
- Code maintainability
- Separation of concerns
- Testability
- Scalability

### 🔁 MVVM Data Flow
```
View ↔ ViewModel ↔ Repository ↔ Network/API
```

### 📁 MVVM Structure Overview
```
lib/
├── Models/         # Data models
├── repository/     # API logic per feature
├── view_model/     # ViewModel business logic
│   ├── controller/
│   └── services/
├── Views/          # UI (screens & widgets)
```

---

## 📂 Project Structure

```
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
│ └── custom_text_field.dart ← moved from common/
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


---

## 🧰 Tech Stack

### 💻 Frontend Technologies

The MedCare app is built using the **Flutter SDK**, a powerful UI framework for crafting natively compiled applications for mobile, web, and desktop from a single codebase. It uses **Dart** as the primary programming language, known for its speed and developer-friendly syntax.

### 📦 Packages Utilized

To enhance functionality and maintain a smooth user experience, the app integrates several Flutter packages:

- `cupertino_icons`: Provides iOS-style icons for a native look and feel.
- `file_picker`: Enables users to select and upload files (like PDFs) from their device.
- `image_picker`: (Currently unused) Intended for picking images from the gallery or camera.
- `logger`: Helps with structured logging for debugging.
- `http`: Handles communication with REST APIs.
- `shared_preferences`: Used for storing user tokens and session data locally.
- `path`: Assists in managing file paths.
- `url_launcher`: Allows the app to open URLs and files in the appropriate external apps.
- `provider`: Implements state management across the app.
- `http_parser`: Helps define content types during multipart uploads.

### 📡 API Communication

The app communicates with a backend server using standard REST API methods:

- `POST` requests are used for user login, registration, and uploading medical reports.
- `GET` requests are used to retrieve appointment data, doctor listings, and uploaded documents.

### 🔐 Authentication Strategy

MedCare uses **JWT-based authentication**, which includes both **access** and **refresh tokens**. These tokens are stored securely on the device using `shared_preferences`, allowing the app to maintain secure sessions across launches.

---

## 🧪 Testing

For API and backend testing, **Postman** has been used extensively to validate request/response structures, headers, and error handling. This ensures seamless integration between frontend and backend systems.

---

## 🚀 Getting Started

To run the MedCare Flutter application on your local machine, follow these steps:

### 1. Clone the Repository

```bash
git clone https://github.com/Amalramesan/medicare.git
cd medcare_flutter


### 2. Install dependencies
```bash
flutter pub get
```

### 3. Run the app
```bash
flutter run
```

---

## 📌 Notes
- Ensure API URLs match your **local IP and port** (e.g., Django backend).
- The app uses **token-based authentication** (Access + Refresh tokens).
- If you change your backend URL, update `res/app_url.dart`.
