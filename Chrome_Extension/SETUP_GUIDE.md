# Google Meet Extension - Complete Setup Guide

This extension integrates AI-powered quiz generation with Google Meet for pairing students and conducting competitive quizzes.

## Architecture

1. **Chrome Extension** - Overlay UI in Google Meet
2. **Node.js Server** (port 3000) - API gateway for GIF, Flashcard, and Quiz generation
3. **FastAPI Quiz Generator** (port 9000 for FastAPI) - LLM-based quiz generation using Google Gemini
4. **Django Backend** (port 8000 for Django) - WebSocket chat and quiz/competition management

## Prerequisites

- Python 3.10+ with virtual environment
- Node.js 16+
- Google Gemini API Key

## Setup Instructions

### 1. Install Dependencies

#### Node.js Server
```powershell
cd server
npm install
```

#### Django Backend
```powershell
cd final_SyncSolve-fe39ef375cc20aac6fb95dcfbfae2da8452cd99e
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python manage.py migrate
```

#### Quiz Generator (FastAPI)
```powershell
cd quiz_generator_2
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

### 2. Environment Variables

Ensure these files have the correct API keys:

- `server/.env` - Contains GEMINI_API_KEY
- `quiz_generator_2/.env` - Contains GEMINI_API_KEY

### 3. Running All Services

**Terminal 1 - Node.js Server (port 3000)**
```powershell
cd server
npm start
```

**Terminal 2 - FastAPI Quiz Generator (port 9000)**
```powershell
cd quiz_generator_2
.\.venv\Scripts\Activate.ps1
uvicorn api_server:app --host 0.0.0.0 --port 9000
```

**Terminal 3 - Django Backend (port 8000)**
```powershell
cd final_SyncSolve-fe39ef375cc20aac6fb95dcfbfae2da8452cd99e
.\.venv\Scripts\Activate.ps1
python manage.py runserver
```

### 4. Load Extension in Chrome

1. Open Chrome and go to `chrome://extensions/`
2. Enable "Developer mode"
3. Click "Load unpacked"
4. Select the `google_meet_ext_2/Extension` folder
5. Join a Google Meet session

## Feature: Pair & Post Chat Links with AI Quiz

### User Flow

1. **Click "Pair & Post Chat Links"** button in the ClassBoost overlay
2. **Enter topic** (e.g., "Photosynthesis", "Machine Learning", etc.)
3. **AI generates 5 MCQ questions** using Google Gemini LLM
4. **System pairs participants** from the Google Meet session
5. **Posts chat links** with unique quiz URLs for each pair
6. **Students join chat rooms** and compete on the quiz
7. **System tracks scores** and determines winners

### Technical Flow

```
Extension (content.js)
  ↓ Click button → Topic modal
  ↓ User enters topic
  ↓ Send to background.js
  
Background.js
  ↓ POST /api/generate-quiz → Node Server
  
Node Server (port 3000)
  ↓ POST /generate-quiz → FastAPI (port 9000)
  
FastAPI Quiz Generator
  ↓ Call Google Gemini LLM
  ↓ Generate 5 MCQ questions
  ↓ Return JSON quiz
  
Node Server
  ↓ Return quiz to extension
  
Extension (content.js)
  ↓ Pair participants
  ↓ POST /api/quiz/create/ → Django (port 8000)
  
Django Backend
  ↓ Store quiz in database
  ↓ Return quiz_id
  
Extension (content.js)
  ↓ Generate chat links: http://127.0.0.1:8000/chat/{roomId}?quiz={quizId}
  ↓ Post to Google Meet chat
  
Students
  ↓ Click links → Django chat platform
  ↓ Answer MCQ questions
  ↓ Scores stored in Django database
```

## Port Configuration

- **3000** - Node.js Express Server
- **8000** - Django Backend
- **9000** - FastAPI Quiz Generator

## Troubleshooting

### Quiz Generator Not Running
```powershell
cd quiz_generator_2
.\.venv\Scripts\Activate.ps1
uvicorn api_server:app --host 0.0.0.0 --port 9000 --reload
```

### Django Server Not Running
```powershell
cd final_SyncSolve-fe39ef375cc20aac6fb95dcfbfae2da8452cd99e
.\.venv\Scripts\Activate.ps1
python manage.py runserver
```

### Node Server Not Running
```powershell
cd server
npm start
```

### API Key Issues
Check that `GEMINI_API_KEY` is set in both:
- `server/.env`
- `quiz_generator_2/.env`

### Extension Not Loading
1. Check `chrome://extensions/` for errors
2. Ensure all services are running
3. Check browser console (F12) for errors
4. Reload extension after code changes

## Development

After making changes to the extension files:
1. Go to `chrome://extensions/`
2. Click reload button on the extension
3. Refresh the Google Meet page

## API Endpoints

### Node.js Server (port 3000)
- `POST /api/generate-quiz` - Generate quiz from topic
- `GET /api/generateGif?topic=X` - Generate GIF
- `GET /api/generateFlashcard?topic=X` - Generate flashcard
- `POST /api/snapshot` - Submit engagement snapshot
- `GET /api/classScore` - Get class engagement score

### FastAPI Quiz Generator (port 9000)
- `POST /generate-quiz` - Generate quiz questions using Gemini LLM
- `GET /health` - Health check

### Django Backend (port 8000)
- `POST /api/quiz/create/` - Create new quiz
- `GET /api/quiz/{quiz_id}/` - Get quiz details
- `POST /api/competition/create/` - Create competitive session
- `GET /api/competition/{session_id}/` - Get competition details
- `GET /chat/{room_id}/` - Chat room interface
