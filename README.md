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

## 🛠️ Technologies Used

### Frontend

- **Flutter** (Dart)
- `http`, `shared_preferences`, `file_picker`

### Backend

- **Django REST Framework**
- Handles user auth, appointment management, and file uploads

---

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
