# Attendance Android App

An innovative attendance tracking application for educational institutions using Bluetooth Low Energy (BLE) technology, face recognition, and real-time synchronization with a backend server.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Installation](#installation)
- [Usage](#usage)
  - [Student Flow](#student-flow)
  - [Teacher Flow](#teacher-flow)
- [Key Components](#key-components)
- [Database Schema](#database-schema)
- [API Integration](#api-integration)
- [Permissions](#permissions)
- [Troubleshooting](#troubleshooting)
- [Future Enhancements](#future-enhancements)

---

## 🎯 Overview

This app streamlines the attendance marking process in educational institutions by leveraging Bluetooth Low Energy (BLE) technology. Teachers create attendance sessions which broadcast unique tokens via BLE, and students scan these tokens to mark their attendance automatically. The app supports face recognition for student verification and maintains both local and remote attendance records.

**Key Advantages:**

- **No Manual Marking**: Automated attendance via BLE scanning
- **No Internet Required**: BLE works offline; sync when available
- **Secure & Verified**: Face recognition ensures authentic attendance
- **Real-time Tracking**: Live updates of student attendance during sessions
- **Multi-role Support**: Separate interfaces for teachers and students

---

## ✨ Features

### Student Features

- 📱 **BLE Scanning**: Automatically detect nearby teacher broadcasting tokens
- 👤 **Face Recognition**: Enroll face and verify for attendance marking
- 📊 **Attendance History**: View all attended classes with timestamps
- 🔐 **Secure Login**: College email-based authentication
- 💾 **Offline Support**: Local attendance records stored in database
- 📡 **Auto-sync**: Sync attendance to backend when online

### Teacher Features

- 📡 **BLE Broadcasting**: Create attendance sessions and broadcast tokens
- 👥 **Attendance Management**: Real-time view of marked and unmarked students
- ✏️ **Manual Adjustments**: Add or remove attendance as needed
- 📋 **Class Management**: Organize classes by year, branch, and section
- 🗑️ **Session Cleanup**: Automatic deletion of sessions on app exit
- 📊 **Attendance Archive**: Archive completed classes for record-keeping

### Common Features

- 🎨 **Material Design 3**: Modern, responsive UI
- 🌓 **Dark Theme Support**: Comfortable for any lighting condition
- ⚙️ **Profile Management**: Edit college info and preferences
- 🔔 **Permissions Management**: Runtime permission requests
- 🎯 **Role-based Navigation**: Customized interface per user role

---

## 🛠️ Tech Stack

### Frontend

- **Kotlin**: Primary programming language
- **Jetpack Compose**: Modern declarative UI framework
- **Material Design 3**: Latest Material design system
- **AndroidX Navigation**: Robust in-app navigation
- **DataStore**: Asynchronous key-value storage for user preferences

### Backend Integration

- **HTTP/REST API**: REST endpoints for class, student, and teacher management
- **JSON Serialization**: org.json for JSON parsing
- **Coroutines**: Asynchronous operations for network requests

### Local Database

- **Room Database**: Type-safe database access layer
- **SQLite**: Underlying database engine
- **Flow**: Reactive data streams for real-time updates

### Bluetooth

- **Android BLE API**: Low Energy advertising and scanning
- **UUID Service Data**: Token transmission via BLE service data

### Face Recognition

- **ML Kit Face Detection**: On-device face detection and recognition
- **Face Embedding**: Vector-based face representation storage

### Development Tools

- **Gradle**: Build automation
- **Android Studio**: IDE
- **Git**: Version control

---

## 🏗️ Architecture

### Project Structure

```
app/src/main/
├── java/com/example/attendance_android/
│   ├── MainActivity.kt                    # Application entry point
│   ├── NavHost.kt                         # Navigation graph setup
│   ├── NavRoutes.kt                       # Route definitions
│   ├── components/                        # UI Composables
│   │   ├── Header_Footer.kt              # Navigation components
│   │   ├── StudentHomeScreen.kt          # Student home screen
│   │   ├── TeacherHomeScreen.kt          # Teacher home screen
│   │   ├── StudentBLE.kt                 # Student BLE scanning logic
│   │   ├── Advertise.kt                  # Teacher BLE advertising
│   │   ├── OnboardingScreen.kt           # Onboarding flow
│   │   ├── FaceEnrollmentScreen.kt       # Face enrollment
│   │   ├── FaceVerifyScreen.kt           # Face verification
│   │   └── ProfileScreen.kt              # User profile
│   ├── data/                              # Database and DataStore
│   │   ├── ClassEntity.kt                # Class data model
│   │   ├── ClassDao.kt                   # Class data access
│   │   ├── ClassDatabase.kt              # Class database
│   │   ├── PresentEntity.kt              # Attendance data model
│   │   ├── PresentDao.kt                 # Attendance data access
│   │   ├── PresentDatabase.kt            # Attendance database
│   │   ├── DataStoreManager.kt           # User preferences
│   │   └── EMBEDDING.kt                  # Face embedding storage
│   ├── ViewModels/                        # Business logic
│   │   ├── OnboardingViewModel.kt        # Onboarding state
│   │   ├── TeacherClassViewModel.kt      # Teacher class management
│   │   └── OnboardingViewModelFactory.kt # ViewModel factory
│   └── ui/theme/                          # Theme and styling
└── res/
    ├── drawable/                          # Images and vectors
    ├── values/                            # Colors, strings, dimensions
    └── xml/                               # Configuration files
```

### Data Flow Architecture

```
┌─────────────────┐
│   MainActivity  │ (Entry point, NavHost, Permissions)
└────────┬────────┘
         │
    ┌────▼────────────────────────────┐
    │   Navigation Graph              │
    │  ├─ Splash Screen              │
    │  ├─ Onboarding                 │
    │  ├─ Student/Teacher Home       │
    │  ├─ BLE Screens                │
    │  └─ Profile                    │
    └────┬────────────────────────────┘
         │
    ┌────┴──────────────────────────────┐
    │   DataStore (User Preferences)    │
    │  ├─ Name, Email, Role            │
    │  ├─ Roll Number                  │
    │  ├─ Branch, Section, Year        │
    │  └─ Face Embedding               │
    └──────────────────────────────────┘
         │
    ┌────┴──────────────────────────────┐
    │   Room Databases                 │
    │  ├─ ClassDatabase (Classes)      │
    │  └─ PresentDatabase (Attendance) │
    └─────────────────────────────────┘
         │
    ┌────┴──────────────────────────────┐
    │   Backend REST API                │
    │  ├─ /api/teacher/check            │
    │  ├─ /api/student/check            │
    │  ├─ /api/class/create             │
    │  ├─ /api/class/mark/{token}/{roll}│
    │  ├─ /api/class/branches/{token}   │
    │  ├─ /api/class/archive            │
    │  └─ /api/class/delete/{token}     │
    └──────────────────────────────────┘
         │
    ┌────┴──────────────────────────────┐
    │   BLE Communication              │
    │  ├─ Teacher: Advertiser          │
    │  └─ Student: Scanner             │
    └──────────────────────────────────┘
```

---

## 📦 Installation

### Prerequisites

- Android Studio Flamingo or later
- Android SDK 28 or higher (target SDK 34)
- Kotlin 1.9.0 or later
- Gradle 8.x

### Setup Steps

1. **Clone the Repository**

   ```bash
   git clone https://github.com/kalyanram360/Attendance_Android.git
   cd Attendance_Android
   ```

2. **Open in Android Studio**

   - Open Android Studio
   - Select "Open an existing project"
   - Navigate to the cloned directory
   - Wait for Gradle sync to complete

3. **Install Dependencies**

   - Gradle will automatically download all dependencies
   - Key dependencies include:
     - AndroidX libraries
     - Jetpack Compose
     - Room Database
     - Google ML Kit

4. **Configure Backend URL**

   - Open `components/Advertise.kt`
   - Update `backendBaseUrl` variable if using different backend
   - Current: `https://attendance-app-backend-zr4c.onrender.com`

5. **Build the Project**

   ```bash
   ./gradlew build
   ```

6. **Run on Device/Emulator**
   - Connect Android device or start emulator
   - Click "Run" in Android Studio or:
   ```bash
   ./gradlew installDebug
   ```

---

## 📱 Usage

### First-Time Setup

**Onboarding Flow:**

1. **Welcome Screen** → App splash screen with logo
2. **Institute Selection** → Choose your college
3. **Role Selection** → Select Student or Teacher
4. **Credentials** → Enter name and college email
5. **Activation Code** → Enter institution-provided activation code
6. **Verification** → App verifies credentials with backend
7. **Face Enrollment** (Students only) → Capture face for verification

### Student Flow

**Marking Attendance:**

1. Open app → Navigate to Home
2. Tap "Start Scanning" or similar button
3. App scans for nearby BLE signals from teachers
4. When teacher's token is detected:
   - Student's face is verified
   - Attendance marked in local database
   - Synced to backend (if online)
5. View attendance history in "Attended Classes" section

**Key Screens:**

- **Home Screen**: Shows attended classes with timestamps
- **BLE Scanning Screen**: Real-time scanning status and detected classes
- **Profile**: View and edit user information

### Teacher Flow

**Creating an Attendance Session:**

1. Open app → Navigate to Home
2. Tap "Create Class" or "Start Session"
3. Select year, branch, and section
4. Select subject
5. Tap "Start Broadcasting"
6. App creates a unique token and starts BLE advertising

**During Session:**

1. Real-time list of students who marked attendance
2. Can manually add/remove attendance
3. See student names and roll numbers
4. Automatic class archival on session end

**Key Screens:**

- **Home Screen**: List of active and completed classes
- **Advertising Screen**: Real-time attendance marking interface
- **Class Management**: Manage sections and subject details

---

## 🔧 Key Components

### 1. **StudentBLE.kt**

Handles student-side BLE scanning and attendance marking.

**Key Functions:**

- `scanForClass()`: Initiates BLE scan
- `markAttendance()`: Marks attendance via API
- Face verification before marking
- Duplicate prevention mechanism

### 2. **Advertise.kt**

Handles teacher-side BLE advertising and session management.

**Key Functions:**

- `startBleAdvertising()`: Begins BLE broadcast
- `fetchFullClassDetails()`: Retrieves attendance details
- `deleteClassFromServer()`: Cleanup on session end
- Real-time attendance updates

### 3. **DataStoreManager.kt**

Manages user preferences and encrypted storage.

**Stored Data:**

- User name, email, role
- Student roll number
- Branch, section, year
- Face embedding (base64)
- Onboarding completion flag

### 4. **Room Databases**

**ClassDatabase:**

- Stores archived classes
- Fields: id, token, subject, createdAt

**PresentDatabase:**

- Stores attendance records
- Fields: id, subject, teacher, createdAt

### 5. **Header & Footer Navigation**

- **HeaderWithProfile**: Shows user info and profile access
- **FooterNavPrimary**: Bottom navigation bar
  - HOME: Student/Teacher main screens
  - CLASSES: Attendance view screen

---

## 💾 Database Schema

### ClassEntity (Archived Classes)

```kotlin
@Entity(tableName = "classes")
data class ClassEntity(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val token: String,           // Unique session token
    val subject: String,         // Class subject
    val createdAt: Long         // Timestamp in milliseconds
)
```

### PresentEntity (Attendance Records)

```kotlin
@Entity(tableName = "present_students")
data class PresentEntity(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val subject: String,        // Class subject
    val teacher: String,        // Teacher email/name
    val createdAt: Long        // Attendance mark timestamp
)
```

---

## 🌐 API Integration

### Base URL

```
https://attendance-app-backend-zr4c.onrender.com
```

### Endpoints

#### 1. **Check Teacher Credentials**

```
GET /api/teacher/check/{email}
Response:
{
  "exists": true,
  "data": {
    "name": "Dr. John Smith",
    "collegeEmail": "john@college.edu",
    "role": "TEACHER"
  }
}
```

#### 2. **Check Student Credentials**

```
GET /api/student/check/{email}
Response:
{
  "exists": true,
  "data": {
    "name": "Jane Doe",
    "collegeEmail": "jane@college.edu",
    "rollno": "2021001",
    "branch": "CSE",
    "section": "A",
    "year": "II"
  }
}
```

#### 3. **Create Class Session**

```
POST /api/class/create
Body:
{
  "teacherEmail": "john@college.edu",
  "subject": "Data Structures",
  "token": "a1b2c3d4e5",
  "sections": [
    {"year": 2, "branch": "CSE", "section": "A"}
  ]
}
Response:
{
  "success": true,
  "message": "Class created successfully"
}
```

#### 4. **Mark Attendance**

```
PATCH /api/class/mark/{token}/{rollno}
Response:
{
  "success": true,
  "message": "Attendance marked"
}
```

#### 5. **Fetch Class Branches & Students**

```
GET /api/class/branches/{token}
Response:
{
  "success": true,
  "data": {
    "branches": [
      {
        "branchName": "CSE",
        "sections": [
          {
            "sectionName": "A",
            "year": 2,
            "students": [
              {"rollNo": "2021001", "name": "Jane Doe", "present": true}
            ]
          }
        ]
      }
    ]
  }
}
```

#### 6. **Delete Class Session**

```
DELETE /api/class/delete/{token}
Response:
{
  "success": true,
  "message": "Class deleted"
}
```

#### 7. **Archive Class**

```
POST /api/class/archive
Body:
{
  "classObject": {...}
}
Response:
{
  "success": true,
  "message": "Class archived"
}
```

---

## 🔐 Permissions

### Android Permissions Required

```xml
<!-- Bluetooth -->
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />

<!-- Camera (Face Recognition) -->
<uses-permission android:name="android.permission.CAMERA" />

<!-- Location (Android 12+) -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### Runtime Permission Requests

- Permissions are requested on app startup in `MainActivity.kt`
- Handled via `ActivityResultContracts.RequestMultiplePermissions()`
- Requests: Camera, Location, Bluetooth (Scan/Advertise/Connect)

---

## 🐛 Troubleshooting

### BLE Not Working

- **Ensure Bluetooth is enabled** on both devices
- **Check permissions** are granted in app settings
- **Both devices must be within ~100 meters** for BLE range
- **Restart the app** if scanning doesn't start

### Attendance Not Marked

- **Face verification might have failed**: Re-enroll face in profile
- **Network error**: Check backend connectivity
- **Token mismatch**: Ensure student is scanning correct teacher's broadcast
- **Check logs**: Look for error messages in logcat

### App Crashes on Launch

- **Clear app data**: Settings → Apps → Attendance → Storage → Clear
- **Update to latest Android version** if possible
- **Reinstall the app**
- **Check device compatibility** (requires Android 8.0+)

### Attendance History Not Showing

- **Sync with backend**: Toggle airplane mode off/on
- **Check device storage**: Ensure sufficient space available
- **Database corruption**: Clear app data and re-login

---

## 🚀 Future Enhancements

### Planned Features

1. **Push Notifications**: Real-time alerts for attendance events
2. **Analytics Dashboard**: Teacher insights on attendance patterns
3. **QR Code Alternative**: Backup to BLE for attendance
4. **Biometric Authentication**: Fingerprint/Face for app login
5. **Attendance Reports**: PDF export of attendance records
6. **Geofencing**: Location-based class verification
7. **Multi-device Sync**: Sync attendance across devices
8. **Offline Mode Improvements**: Enhanced offline queuing

### Technical Improvements

1. **Encryption**: End-to-end encryption for attendance data
2. **Caching Strategy**: Improved offline caching mechanism
3. **Error Handling**: Enhanced error recovery and retry logic
4. **Performance Optimization**: Reduce app size and memory usage
5. **Unit Tests**: Comprehensive test coverage
6. **CI/CD Pipeline**: Automated testing and deployment

---

## 👥 Contributors

- **Kalyan Ram** - Lead Developer
- Backend Team - API Development
- UX/UI Team - Design and User Experience

---

## 🎓 How It Works - Quick Overview

```
┌──────────────────────────────────────────┐
│  STUDENT ATTENDANCE MARKING FLOW         │
├──────────────────────────────────────────┤
│                                          │
│  1. Student Opens App                   │
│     ↓                                    │
│  2. Navigates to Home → Start Scanning  │
│     ↓                                    │
│  3. BLE Scanner Activated               │
│     ↓                                    │
│  4. Detects Teacher's BLE Signal        │
│     ↓                                    │
│  5. Verifies Student's Face             │
│     ↓                                    │
│  6. Marks Attendance via API            │
│     ↓                                    │
│  7. Saves to Local Database             │
│     ↓                                    │
│  8. Success! ✓                          │
│                                          │
└──────────────────────────────────────────┘
```

---
