# 🎓 ClassBoost - Google Meet Extension with AI Quiz Generation

An intelligent Chrome extension that enhances Google Meet with AI-powered features including quiz generation, student pairing, engagement tracking, and more.

## 🚀 Quick Start

### 1. Install Dependencies
```powershell
# Install Node.js dependencies
cd server
npm install
cd ..

# Install Python dependencies for Django
cd final_SyncSolve-fe39ef375cc20aac6fb95dcfbfae2da8452cd99e
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python manage.py migrate
cd ..

# Install Python dependencies for Quiz Generator
cd quiz_generator_2
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
cd ..
```

### 2. Start All Services
```powershell
# Run the startup script (opens 3 terminal windows)
.\start_all_services.ps1
```

**OR** manually start each service:

```powershell
# Terminal 1 - Node.js (port 3000)
cd server
npm start

# Terminal 2 - FastAPI Quiz Generator (port 9000)
cd quiz_generator_2
.\.venv\Scripts\Activate.ps1
uvicorn api_server:app --host 0.0.0.0 --port 9000

# Terminal 3 - Django Backend (port 8000)
cd final_SyncSolve-fe39ef375cc20aac6fb95dcfbfae2da8452cd99e
.\.venv\Scripts\Activate.ps1
python manage.py runserver
```

### 3. Load Extension in Chrome
1. Open Chrome → `chrome://extensions/`
2. Enable **Developer mode**
3. Click **Load unpacked**
4. Select this folder
5. Join a Google Meet session

## ✨ Features

### 🤖 AI-Powered Quiz Generation (NEW!)
- Click **"Pair & Post Chat Links"**
- Enter any topic (e.g., "Photosynthesis", "Python Programming")
- AI generates 5 MCQ questions using Google Gemini
- Automatically pairs students and posts quiz links in chat
- Students compete head-to-head with real-time scoring

### 📊 Engagement Meter
- Real-time class attention tracking
- Visual speedometer gauge
- Automatic low-engagement alerts

### 🎬 GIF Generator
- Generate relevant educational GIFs
- Powered by Google Custom Search

### 📇 Flashcard Generator
- AI-generated flashcards for any topic
- Powered by Google Gemini

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Chrome Extension                          │
│  (content.js, background.js, overlay UI)                    │
└────┬──────────────────────┬──────────────────────┬──────────┘
     │                      │                      │
     ▼                      ▼                      ▼
┌──────────────┐   ┌──────────────────┐   ┌─────────────────┐
│   Node.js    │   │  FastAPI Quiz    │   │ Django Backend  │
│   Server     │──▶│   Generator      │   │  (Chat & DB)    │
│  (port 3000) │   │   (port 9000)    │   │   (port 8000)   │
│              │   │                  │   │                 │
│ - GIF API    │   │ - Gemini LLM     │   │ - Quiz Storage  │
│ - Flashcard  │   │ - Quiz Gen API   │   │ - WebSocket     │
│ - Gateway    │   │                  │   │ - Leaderboard   │
└──────────────┘   └──────────────────┘   └─────────────────┘
```

## 📡 API Ports

| Service | Port | Purpose |
|---------|------|---------|
| Node.js Express | 3000 | API gateway, GIF/Flashcard generation |
| FastAPI Quiz Gen | 9000 | AI quiz generation using Gemini |
| Django Backend | 8000 | Chat platform, quiz storage, scoring |

## 🎯 How "Pair & Post Chat Links" Works

1. **Teacher clicks button** → Topic modal appears
2. **Enter topic** (e.g., "Machine Learning")
3. **AI generates quiz** → FastAPI calls Gemini LLM for 5 MCQs
4. **System pairs students** → Randomly pairs participants from Meet
5. **Creates Django quizzes** → One quiz per pair stored in database
6. **Posts chat links** → Links appear in Google Meet chat
7. **Students compete** → Click link → Answer questions → Real-time scoring
8. **Results tracked** → Winners determined, scores stored

## 🔑 Configuration

### Environment Variables

**server/.env**
```env
GOOGLE_API_KEY=your_google_api_key
GOOGLE_SEARCH_ENGINE_ID=your_search_engine_id
GEMINI_API_KEY=your_gemini_api_key
QUIZ_API_URL=http://localhost:9000
```

**quiz_generator_2/.env**
```env
GEMINI_API_KEY=your_gemini_api_key
```

## 🛠️ Development

### After Code Changes
1. Go to `chrome://extensions/`
2. Click ⟳ (reload) on the extension
3. Refresh Google Meet page

### Check Logs
- **Extension**: F12 → Console in Google Meet
- **Node.js**: Terminal running npm start
- **FastAPI**: Terminal running uvicorn
- **Django**: Terminal running runserver

## 📝 Testing the Integration

1. Start all services (use `start_all_services.ps1`)
2. Open Google Meet with 2+ participants
3. Click "Pair & Post Chat Links"
4. Enter topic: "Test Topic"
5. Check Meet chat for quiz links
6. Click a link → Should open Django chat with quiz
7. Answer questions → Check scores

## 🐛 Troubleshooting

### Services won't start
```powershell
# Check if ports are in use
netstat -ano | findstr "3000"
netstat -ano | findstr "8000"  
netstat -ano | findstr "9000"
```

### Quiz generation fails
- Check FastAPI logs for Gemini API errors
- Verify GEMINI_API_KEY in quiz_generator_2/.env
- Test endpoint: http://localhost:9000/health

### Extension not visible
- Ensure all 3 services are running
- Check for errors in chrome://extensions/
- Check browser console (F12) for errors

### Pairing doesn't work
- Need at least 2 participants in Meet
- Check if Django server (port 8000) is running
- Check network tab for failed API calls

## 📚 Documentation

See [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed setup instructions.

## 🤝 Contributing

This is a hackathon project integrating:
- Chrome Extension APIs
- Google Gemini AI
- FastAPI for ML services
- Django for backend
- WebSockets for real-time chat

## 📄 License

Hackathon Project - Educational Use
