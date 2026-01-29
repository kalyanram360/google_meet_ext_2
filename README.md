# 🎓 Smart Attendance and Engagement Tracking System


> **A comprehensive hackathon project combining Google Meet integration, attendance tracking, and AI-powered educational tools**

![Status](https://img.shields.io/badge/Status-Hackathon%20Ready-brightgreen)
![Platform](https://img.shields.io/badge/Platform-Web%20%2B%20Android-blue)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Project Architecture](#-project-architecture)
- [Key Features](#-key-features)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Quick Start](#-quick-start)
- [Detailed Setup](#-detailed-setup)
- [Component Details](#-component-details)
- [API Documentation](#-api-documentation)
- [Usage Guide](#-usage-guide)
- [Troubleshooting](#-troubleshooting)
- [Team & Credits](#-team--credits)

---

## 🌟 Overview

**ClassBoost** is an innovative educational platform that enhances the online learning experience through:

1. **🎯 Chrome Extension for Google Meet** - AI-powered quiz generation, engagement tracking, and interactive features
2. **📱 Attendance Android App** - BLE-based automatic attendance with face recognition
3. **📊 Student Dashboard** - Real-time analytics and performance visualization
4. **🤖 AI Services** - Google Gemini-powered quiz generation and educational content

### Problem Statement

Online education faces challenges:
- Low student engagement in virtual classes
- Manual attendance marking is time-consuming
- Lack of interactive learning tools
- Difficulty in assessing real-time class participation

### Our Solution

ClassBoost provides an integrated ecosystem that:
- ✅ Automatically tracks attendance using BLE technology
- ✅ Monitors student engagement in real-time
- ✅ Generates AI-powered quizzes and educational content
- ✅ Creates competitive learning experiences
- ✅ Provides analytics for students and teachers

---

## 🏗️ Project Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    CLASSBOOST ECOSYSTEM                      │
└─────────────────────────────────────────────────────────────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
┌───────────────┐  ┌──────────────┐  ┌──────────────┐
│ Chrome Ext    │  │  Android App │  │  Web Dashboard│
│ (Google Meet) │  │  (Attendance)│  │  (Analytics)  │
└───────┬───────┘  └──────┬───────┘  └──────┬────────┘
        │                 │                  │
        └─────────────────┼──────────────────┘
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
        ▼                 ▼                 ▼
┌──────────────┐  ┌─────────────┐  ┌──────────────┐
│ Node.js      │  │  Django     │  │  FastAPI     │
│ Server       │  │  Backend    │  │  Quiz Gen    │
│ (Port 3000)  │  │  (Port 8000)│  │  (Port 9000) │
└──────┬───────┘  └─────┬───────┘  └──────┬────────┘
       │                │                  │
       └────────────────┼──────────────────┘
                        │
                        ▼
              ┌──────────────────┐
              │   Google Gemini  │
              │   LLM API        │
              └──────────────────┘
              ┌──────────────────┐
              │   MongoDB        │
              └──────────────────┘
```

---

## ✨ Key Features

### 🎯 Chrome Extension (ClassBoost for Google Meet)

- **AI-Powered Quiz Generation**: Generate 5 MCQ questions on any topic using Google Gemini
- **Student Pairing & Competition**: Automatically pair students and create competitive quiz sessions
- **Real-time Engagement Tracking**: Monitor class attention with visual speedometer
- **GIF Search**: Educational GIF generation for visual learning
- **Flashcard Generator**: Create study flashcards on-the-fly
- **WebSocket Chat**: Real-time collaboration between paired students

### 📱 Android Attendance App

- **BLE-Based Attendance**: Automatic attendance marking via Bluetooth Low Energy
- **Face Recognition**: ML Kit-powered face verification for security
- **Offline Support**: Works without internet, syncs when available
- **Teacher Dashboard**: Real-time attendance monitoring
- **Student Portal**: View attendance history and statistics
- **Role-Based Access**: Separate interfaces for teachers and students

### 📊 Student Analytics Dashboard

- **Performance Visualization**: Interactive charts and graphs using Recharts
- **Attendance Reports**: Track attendance patterns over time
- **Quiz Performance**: Analyze quiz scores and improvement trends
- **Responsive Design**: Material Design with Tailwind CSS

### 🤖 AI Services

- **Google Gemini Integration**: Advanced AI for quiz generation
- **Context-Aware Questions**: Topic-specific educational content
- **Adaptive Difficulty**: Questions tailored to learning level

---

## 🛠️ Tech Stack

### Frontend
- **Chrome Extension**: Vanilla JavaScript, CSS3
- **Android App**: Kotlin, Jetpack Compose, Material Design 3
- **Web Dashboard**: React 18, Tailwind CSS, Recharts

### Backend
- **Node.js Server**: Express.js, Socket.IO, CORS
- **Django Backend**: Django 4.x, Channels, WebSockets, REST API
- **FastAPI Service**: FastAPI, Uvicorn, Google Generative AI

### Database & Storage
- **MongoDB**: College data, attendance records
- **SQLite (Django)**: Quiz data, competitive sessions
- **Room Database (Android)**: Local attendance cache

### AI & ML
- **Google Gemini API**: Quiz generation, flashcards
- **ML Kit Face Detection**: Android face recognition

### DevOps & Tools
- **Version Control**: Git
- **Package Managers**: npm, pip, Gradle
- **Environment**: .env for configuration
- **API Testing**: Postman-ready endpoints

---

## 📁 Project Structure

```
google_meet_ext_2/
│
├── Chrome_Extension/              # Main Chrome extension + services
│   ├── manifest.json              # Extension configuration
│   ├── content.js                 # Google Meet overlay UI (1700+ lines)
│   ├── background.js              # Service worker
│   ├── overlay.css                # Styling
│   ├── start_all_services.ps1    # PowerShell startup script
│   │
│   ├── server/                    # Node.js API Gateway (Port 3000)
│   │   ├── index.js              # Express + Socket.IO server
│   │   ├── package.json          # Dependencies
│   │   └── .env                  # API keys
│   │
│   ├── quiz_generator_2/         # FastAPI Quiz Service (Port 9000)
│   │   ├── api_server.py         # FastAPI endpoints
│   │   ├── app.py                # Streamlit UI (optional)
│   │   ├── requirements.txt      # Python dependencies
│   │   ├── .env                  # Gemini API key
│   │   └── modules/
│   │       └── quiz_generator.py # Quiz generation logic
│   │
│   └── final_SyncSolve-.../      # Django Backend (Port 8000)
│       ├── manage.py             # Django management
│       ├── db.sqlite3            # SQLite database
│       ├── requirements.txt      # Dependencies
│       ├── core/                 # Main app
│       │   ├── models.py         # Quiz, CompetitiveSession models
│       │   ├── views.py          # REST API endpoints
│       │   ├── consumers.py      # WebSocket handlers
│       │   ├── routing.py        # WebSocket routing
│       │   └── templates/        # HTML templates
│       └── syncsolve/
│           ├── settings.py       # Django configuration
│           ├── asgi.py           # ASGI for WebSockets
│           └── urls.py           # URL routing
│
├── Attendance_App_Backend/        # MongoDB Backend (Port 3000)
│   ├── src/
│   │   ├── index.js              # Server entry point
│   │   ├── app.js                # Express app setup
│   │   ├── db/connection.js      # MongoDB connection
│   │   ├── models/               # Mongoose schemas
│   │   │   ├── College.js
│   │   │   ├── Student.js
│   │   │   ├── Teacher.js
│   │   │   ├── NewClass.js
│   │   │   └── Attendance.js
│   │   ├── controlers/           # Business logic
│   │   └── routes/               # API routes
│   ├── package.json
│   │
│   └── frontend/                  # React Analytics Dashboard
│       ├── src/
│       │   ├── App.js
│       │   ├── index.js
│       │   └── components/
│       │       └── Dashboard.js   # Main dashboard component
│       ├── package.json
│       └── tailwind.config.js
│
├── Attendance_App_Frontend/       # Android Application (Kotlin)
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── AndroidManifest.xml
│   │   │   ├── java/com/...      # Kotlin source files
│   │   │   ├── res/              # UI resources
│   │   │   └── assets/
│   │   │       └── output_model.tflite  # Face recognition model
│   │   └── build.gradle.kts
│   ├── build.gradle.kts
│   └── settings.gradle.kts
│
└── README.md                      # This file
```

---

## 🚀 Quick Start

### Prerequisites

Ensure you have installed:
- ✅ **Node.js 16+** & npm
- ✅ **Python 3.10+** with pip
- ✅ **MongoDB** (local or Atlas)
- ✅ **Google Chrome** browser
- ✅ **Android Studio** (for Android app)
- ✅ **Google Gemini API Key** ([Get it here](https://makersuite.google.com/app/apikey))

### One-Command Startup (Windows)

```powershell
# Navigate to Chrome Extension directory
cd Chrome_Extension

# Run all services at once
.\start_all_services.ps1
```

This script starts:
1. Node.js Server (Port 3000)
2. Django Backend (Port 8000)
3. FastAPI Quiz Generator (Port 9000)

### Load Chrome Extension

1. Open Chrome → `chrome://extensions/`
2. Enable **Developer mode**
3. Click **Load unpacked**
4. Select `Chrome_Extension` folder
5. Join a Google Meet session to see ClassBoost overlay

---

## 🔧 Detailed Setup

### 1️⃣ Chrome Extension Services

#### A. Node.js Server (Port 3000)

```powershell
cd Chrome_Extension/server
npm install
```

Create `.env` file:
```env
GEMINI_API_KEY=your_gemini_api_key_here
GOOGLE_API_KEY=your_google_api_key
GOOGLE_SEARCH_ENGINE_ID=your_search_engine_id
```

Start server:
```powershell
npm start
# or for development with auto-reload
npm run dev
```

#### B. FastAPI Quiz Generator (Port 9000)

```powershell
cd Chrome_Extension/quiz_generator_2
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

Create `.env` file:
```env
GEMINI_API_KEY=your_gemini_api_key_here
```

Start FastAPI:
```powershell
uvicorn api_server:app --host 0.0.0.0 --port 9000 --reload
```

Visit API docs: `http://localhost:9000/docs`

#### C. Django Backend (Port 8000)

```powershell
cd Chrome_Extension/final_SyncSolve-fe39ef375cc20aac6fb95dcfbfae2da8452cd99e
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python manage.py migrate
```

Start Django:
```powershell
python manage.py runserver
```

### 2️⃣ Attendance Backend (MongoDB)

```powershell
cd Attendance_App_Backend
npm install
```

Configure `.env`:
```env
MONGODB_URI=mongodb://localhost:27017/attendance
PORT=3000
NODE_ENV=development
```

Start server:
```powershell
npm run dev
```

### 3️⃣ Student Dashboard (React)

```powershell
cd Attendance_App_Backend/frontend
npm install
npm start
```

Access dashboard: `http://localhost:3000`

### 4️⃣ Android App

1. Open `Attendance_App_Frontend` in Android Studio
2. Sync Gradle dependencies
3. Configure backend URL in app (if needed)
4. Build and run on emulator/device

---

## 📦 Component Details

### Chrome Extension Features

#### 🎯 Pair & Post Chat Links
1. Teacher clicks "Pair & Post Chat Links"
2. Enters topic (e.g., "Machine Learning")
3. Extension:
   - Calls Google Gemini via Node.js → FastAPI
   - Generates 5 MCQ questions
   - Pairs Google Meet participants
   - Creates Django quiz sessions
   - Posts chat links to Meet chat

#### 📊 Engagement Meter
- Real-time tracking via Socket.IO
- Visual speedometer (0-100%)
- Alerts when engagement drops below 40%
- Smoothed averaging across all participants

#### 🎬 GIF Generator
- Uses Google Custom Search API
- Educational GIF search
- One-click posting to Meet chat

#### 📇 Flashcard Generator
- Topic-based flashcard creation
- AI-powered content using Gemini
- Visual card display

### Android Attendance System

#### 🔵 BLE Technology
- Teacher broadcasts unique session token
- Students scan automatically within range
- No manual QR codes or check-ins needed

#### 👤 Face Recognition
- Initial enrollment: Capture face
- Verification: Match face on attendance marking
- ML Kit Face Detection for accuracy

#### 📱 Teacher Flow
1. Create class (year, branch, section)
2. Start attendance session
3. BLE broadcast begins automatically
4. Monitor real-time attendance
5. Manual adjustments if needed
6. End session → Archive attendance

#### 👨‍🎓 Student Flow
1. Enable Bluetooth
2. Open app
3. Automatic scanning for nearby sessions
4. Face verification
5. Attendance marked automatically

---

## 🔌 API Documentation

### Node.js Server (Port 3000)

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/generate-quiz` | POST | Generate AI quiz (forwards to FastAPI) |
| `/api/searchGif` | GET | Search educational GIFs |
| `/api/generate-flashcard` | POST | Generate flashcards |
| `/api/classScore` | GET | Get current engagement score |
| `/api/snapshot` | POST | Submit engagement snapshot |

### FastAPI (Port 9000)

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/generate-quiz` | POST | Generate 5 MCQ questions |
| `/docs` | GET | Interactive API documentation |
| `/health` | GET | Health check |

**Request Example:**
```json
POST /generate-quiz
{
  "topic": "Photosynthesis"
}
```

**Response Example:**
```json
{
  "success": true,
  "quiz": {
    "mcq": [
      {
        "question": "What is photosynthesis?",
        "options": ["A", "B", "C", "D"],
        "answer": "A"
      }
    ]
  }
}
```

### Django Backend (Port 8000)

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/quiz/create/` | POST | Create new quiz |
| `/api/quiz/<id>/` | GET | Get quiz details |
| `/api/competition/<id>/` | GET | Get competition session |
| `/chat/<room_id>/` | GET | Chat room (WebSocket) |
| `/active-problems/` | GET | List active problems |

### Attendance Backend (Port 3000)

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/validate` | POST | Validate college details |
| `/api/register` | POST | Register new college |
| `/api/colleges` | GET | List all colleges |
| `/health` | GET | Health check |

---

## 📖 Usage Guide

### For Teachers (Chrome Extension)

1. **Start Services**: Run `start_all_services.ps1`
2. **Join Google Meet**: Open or create a meeting
3. **ClassBoost Overlay**: Appears automatically on Meet page
4. **Generate Quiz**:
   - Click "Pair & Post Chat Links"
   - Enter topic
   - Wait for AI generation
   - Links posted to chat automatically
5. **Monitor Engagement**:
   - Click "Engagement Meter"
   - View real-time speedometer
   - Respond to low-engagement alerts

### For Students (Chrome Extension)

1. Join Google Meet session
2. Click chat links posted by teacher
3. Enter name
4. Answer quiz questions
5. Compete with paired partner
6. View scores in real-time

### For Teachers (Android App)

1. Login with college email
2. Navigate to "Create Class"
3. Fill in class details
4. Start attendance session
5. Monitor students marking attendance
6. End session when complete

### For Students (Android App)

1. Login with college email
2. Enroll face (first time)
3. Enable Bluetooth
4. App auto-detects nearby sessions
5. Face verification
6. Attendance marked automatically

---

## 🐛 Troubleshooting

### Chrome Extension Issues

**Extension not loading:**
- Check Developer Mode is enabled
- Reload extension from `chrome://extensions/`
- Check console for errors (F12)

**Quiz generation fails:**
- Verify Gemini API key in `server/.env` and `quiz_generator_2/.env`
- Check all 3 services are running (ports 3000, 8000, 9000)
- Check API quotas on Google AI Studio

**WebSocket connection fails:**
- Ensure Django is running on port 8000
- Check CORS settings in Django settings.py
- Verify firewall allows WebSocket connections

### Android App Issues

**Bluetooth not working:**
- Grant Bluetooth permissions in Settings
- Enable Location services (required for BLE)
- Check Android version (BLE requires 5.0+)

**Face recognition fails:**
- Ensure good lighting
- Re-enroll face
- Check camera permissions

**Attendance not syncing:**
- Verify backend URL is correct
- Check internet connection
- View logs in Android Studio Logcat

### Backend Issues

**MongoDB connection error:**
- Start MongoDB service: `mongod`
- Check connection string in `.env`
- Ensure MongoDB port 27017 is open

**Port already in use:**
```powershell
# Find process using port
netstat -ano | findstr :3000

# Kill process
taskkill /PID <process_id> /F
```

**Python virtual environment:**
```powershell
# Reactivate if deactivated
.\.venv\Scripts\Activate.ps1

# Reinstall dependencies
pip install -r requirements.txt
```

---

## 🎯 Key Highlights for Judges

### Innovation
- 🏆 Combines BLE, AI, and WebRTC in one ecosystem
- 🏆 Real-time engagement tracking using computer vision
- 🏆 Offline-first Android app with smart sync

### Technical Complexity
- 🏆 6 interconnected services (Chrome Extension, 3 backends, Android, Web)
- 🏆 Multi-protocol: REST, WebSocket, BLE
- 🏆 AI integration with Google Gemini LLM

### User Experience
- 🏆 Seamless Google Meet integration
- 🏆 Zero manual effort for attendance
- 🏆 Gamified learning with competitions

### Scalability
- 🏆 Modular architecture
- 🏆 Cloud-ready (Django/FastAPI deployable)
- 🏆 Database-agnostic design

---

## 📞 Team & Credits

**Project Name:** ClassBoost  
**Hackathon:** [Your Hackathon Name]  
**Date:** January 2026

### Technologies Used
- Google Gemini API
- Google Custom Search API
- ML Kit Face Detection
- Socket.IO
- Django Channels
- FastAPI
- Jetpack Compose

### License
MIT License - Feel free to use for educational purposes

---

## 🚀 Future Enhancements

- [ ] Speech-to-text for automatic class transcription
- [ ] AI-powered doubt resolution chatbot
- [ ] Integration with LMS platforms (Moodle, Canvas)
- [ ] Mobile app for teachers (iOS/Android)
- [ ] Advanced analytics with ML predictions
- [ ] Multi-language support
- [ ] Cloud deployment (AWS/GCP/Azure)
- [ ] Progressive Web App (PWA) version

---

## 📄 Additional Documentation

- [Chrome Extension Setup Guide](Chrome_Extension/SETUP_GUIDE.md)
- [Android App Full Documentation](Attendance_App_Frontend/README.md)
- [Attendance Backend API](Attendance_App_Backend/README.md)
- [Quiz Generator Documentation](Chrome_Extension/quiz_generator_2/README.md)

---

<div align="center">

**Built with ❤️ for the future of education**

[⭐ Star this repo](https://github.com/yourusername/classboost) | [🐛 Report Bug](https://github.com/yourusername/classboost/issues) | [💡 Request Feature](https://github.com/yourusername/classboost/issues)

</div>
