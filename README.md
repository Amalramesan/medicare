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

### 💻 Frontend
- 🎯 **Dart** – Primary language for Flutter
- 🖼️ **Flutter SDK** – Cross-platform UI framework

### 📦 Packages Used
| Package             | Purpose                                    |
|---------------------|--------------------------------------------|
| `cupertino_icons`   | iOS-style icons                            |
| `file_picker`       | Pick files (PDFs, etc.) from device        |
| `image_picker`      | *(Currently unused)* Image selection       |
| `logger`            | Debug logging                              |
| `http`              | HTTP networking                            |
| `shared_preferences`| Local storage for session/token            |
| `path`              | File system path utilities                 |
| `url_launcher`      | Launch external URLs or files              |
| `provider`          | State management                           |
| `http_parser`       | Handle content types for file uploads      |

---

### 📡 API Communication
- `POST`:  
  - User **login**
  - User **registration**
  - **Report upload** (multipart)
- `GET`:  
  - **Appointments**
  - **Doctor list**
  - **Uploaded medical reports**

---

### 🔐 Authentication
- 🛡️ **JWT Token-Based Authentication**
  - Stores **Access** and **Refresh tokens**
  - Secured using `SharedPreferences`

---

## 🧪 Testing
- 🧪 **Postman** – For testing and validating backend API endpoints.

---

## 🚀 Getting Started

### 🔧 Prerequisites
- ✅ Flutter SDK installed (https://docs.flutter.dev/get-started/install)
- ✅ Dart SDK installed (usually bundled with Flutter)
- ✅ Connected Android/iOS device or emulator

---

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/Amalramesan/medicare.git
cd medcare_flutter

