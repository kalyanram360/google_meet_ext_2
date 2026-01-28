# 🚀 Quick Reference Card

## One-Command Startup

```powershell
.\start_all_services.ps1
```

This opens 3 PowerShell windows for:
- Node.js Server (port 3000)
- FastAPI Quiz Generator (port 9000)
- Django Backend (port 8000)

---

## Manual Startup Commands

### Terminal 1: Node.js
```powershell
cd server
npm start
```

### Terminal 2: FastAPI Quiz Generator
```powershell
cd quiz_generator_2
.\.venv\Scripts\Activate.ps1
uvicorn api_server:app --host 0.0.0.0 --port 9000
```

### Terminal 3: Django Backend
```powershell
cd final_SyncSolve-fe39ef375cc20aac6fb95dcfbfae2da8452cd99e
.\.venv\Scripts\Activate.ps1
python manage.py runserver
```

---

## Service URLs

| Service | URL | Purpose |
|---------|-----|---------|
| Node.js | http://localhost:3000 | API Gateway |
| Quiz Generator | http://localhost:9000 | AI Quiz Gen |
| Django Backend | http://localhost:8000 | Chat Platform |

---

## Quick Health Checks

```powershell
# Check all services at once
curl http://localhost:3000 ; `
curl http://localhost:9000/health ; `
curl http://localhost:8000/api/active_problems/
```

Expected output:
- Node.js: Server response
- FastAPI: `{"status":"healthy"}`
- Django: JSON with active_problems

---

## Extension Commands

### Load Extension
1. Chrome → `chrome://extensions/`
2. Enable "Developer mode"
3. Click "Load unpacked"
4. Select folder: `google_meet_ext_2`

### Reload After Changes
1. Go to `chrome://extensions/`
2. Find "ClassBoost - Meet Overlay"
3. Click ⟳ (reload icon)

---

## Using the Quiz Feature

### Step-by-Step
1. Join Google Meet with 2+ participants
2. Click **"Pair & Post Chat Links"** button
3. Enter topic (e.g., "Photosynthesis")
4. Wait ~10 seconds for AI generation
5. Check Meet chat for quiz links
6. Students click links to start quiz

### What Happens Behind the Scenes
```
Button Click
  → Topic Input
    → AI Generates 5 MCQs (~10 sec)
      → Pairs Students Randomly
        → Creates Quiz in Database
          → Posts Links to Meet Chat
            → Students Compete
              → Scores Tracked
```

---

## Common Commands

### Stop Services
```powershell
# Find processes
netstat -ano | findstr "3000"
netstat -ano | findstr "8000"
netstat -ano | findstr "9000"

# Kill process by PID
taskkill /PID {pid} /F
```

### Check Logs
- **Extension**: F12 in Meet → Console tab
- **Node.js**: Terminal running npm start
- **FastAPI**: Terminal running uvicorn
- **Django**: Terminal running runserver

### Database Reset
```powershell
cd final_SyncSolve-fe39ef375cc20aac6fb95dcfbfae2da8452cd99e
.\.venv\Scripts\Activate.ps1
python manage.py flush
python manage.py migrate
```

---

## Environment Files

### server/.env
```env
GOOGLE_API_KEY=your_key
GEMINI_API_KEY=your_key
QUIZ_API_URL=http://localhost:9000
```

### quiz_generator_2/.env
```env
GEMINI_API_KEY=your_key
```

---

## Testing Shortcuts

### Test Quiz Generation API
```powershell
curl -X POST http://localhost:9000/generate-quiz `
  -H "Content-Type: application/json" `
  -d '{"topic":"Test Topic"}'
```

### Test Django Quiz Creation
```powershell
curl -X POST http://localhost:8000/api/quiz/create/ `
  -H "Content-Type: application/json" `
  -d '{
    "title":"Test Quiz",
    "questions":[{"question":"Q?","options":["A","B","C","D"],"correct_answer":0}],
    "duration":60,
    "difficulty":"easy"
  }'
```

---

## File Locations

```
google_meet_ext_2/
├── manifest.json         (Extension config)
├── content.js            (Meet UI overlay)
├── background.js         (Message handler)
├── overlay.css           (Styling)
├── server/
│   ├── index.js          (Node.js server)
│   └── .env              (API keys)
├── quiz_generator_2/
│   ├── api_server.py     (FastAPI quiz gen)
│   ├── modules/
│   │   └── quiz_generator.py  (LLM integration)
│   └── .env              (Gemini key)
└── final_SyncSolve.../
    ├── manage.py         (Django)
    └── core/
        ├── views.py      (API endpoints)
        └── models.py     (Database models)
```

---

## Troubleshooting Quick Fixes

| Problem | Solution |
|---------|----------|
| Extension not visible | Reload extension + refresh Meet page |
| Quiz gen fails | Check FastAPI logs, verify API key |
| Pairing doesn't work | Need 2+ participants in Meet |
| Chat post fails | Ensure chat panel is open |
| Port in use | Kill process: `taskkill /PID {pid} /F` |
| Service offline | Restart using commands above |

---

## API Endpoints Reference

### Node.js (port 3000)
- `POST /api/generate-quiz` - Generate quiz
- `GET /api/generateGif?topic=X` - Get GIF
- `GET /api/generateFlashcard?topic=X` - Get flashcard
- `POST /api/snapshot` - Submit engagement
- `GET /api/classScore` - Get class score

### FastAPI (port 9000)
- `POST /generate-quiz` - Generate quiz
- `GET /health` - Health check
- `GET /` - API info

### Django (port 8000)
- `POST /api/quiz/create/` - Create quiz
- `GET /api/quiz/{id}/` - Get quiz
- `POST /api/competition/create/` - Create session
- `GET /api/competition/{id}/` - Get session
- `GET /chat/{roomId}/` - Chat room

---

## Extension Features

| Button | Function |
|--------|----------|
| Engagement Meter | Real-time class attention |
| **Pair & Post Chat Links** | **AI Quiz + Student Pairing** |
| Generate GIF | Educational GIF search |
| Generate Flashcard | AI flashcard creation |

---

## Documentation Files

- **README.md** - Quick start guide
- **SETUP_GUIDE.md** - Complete setup
- **TESTING_CHECKLIST.md** - Test procedures
- **INTEGRATION_SUMMARY.md** - What was done
- **ARCHITECTURE.md** - System diagrams
- **QUICK_REFERENCE.md** - This file

---

## Support & Resources

- Check browser console (F12) for errors
- Review service logs in terminals
- Test APIs individually using curl
- See TESTING_CHECKLIST.md for full test suite
- See ARCHITECTURE.md for system design

---

## Success Indicators

✅ All services show "listening" or "started"  
✅ Health checks return 200 OK  
✅ Extension loads without errors  
✅ Quiz generation takes ~10 seconds  
✅ Chat links appear in Meet  
✅ Students can access quiz platform  
✅ Scores are tracked in database  

---

**Quick Tip**: Keep this file open while developing for fast command lookup!
