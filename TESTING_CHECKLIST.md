# 🧪 Integration Testing Checklist

## Pre-Testing Setup

### ✅ All Services Running
- [ ] Node.js Server (port 3000) - `npm start` in server/
- [ ] FastAPI Quiz Generator (port 9000) - `uvicorn api_server:app --port 9000` in quiz_generator_2/
- [ ] Django Backend (port 8000) - `python manage.py runserver` in final_SyncSolve.../

### ✅ Environment Check
```powershell
# Test Node.js Server
curl http://localhost:3000

# Test FastAPI Quiz Generator
curl http://localhost:9000/health

# Test Django Backend
curl http://localhost:8000/api/active_problems/
```

### ✅ Extension Loaded
- [ ] Chrome extension loaded at `chrome://extensions/`
- [ ] No errors shown in extension details
- [ ] Extension icon visible in toolbar

---

## Test 1: Service Health Check

### Node.js Server
```powershell
curl http://localhost:3000
```
**Expected**: Server response

### FastAPI Quiz Generator
```powershell
curl http://localhost:9000/health
```
**Expected**: `{"status": "healthy"}`

### Django Backend
```powershell
curl http://localhost:8000/api/active_problems/
```
**Expected**: JSON response with active_problems

---

## Test 2: Quiz Generation API

### Manual API Test
```powershell
# Create a test JSON file: test_quiz.json
@"
{
  "topic": "Photosynthesis"
}
"@ | Out-File -Encoding utf8 test_quiz.json

# Test FastAPI directly
curl -X POST http://localhost:9000/generate-quiz `
  -H "Content-Type: application/json" `
  -d "@test_quiz.json"
```

**Expected Response**:
```json
{
  "success": true,
  "quiz": {
    "mcq": [
      {
        "question": "...",
        "options": ["A", "B", "C", "D"],
        "answer": "B"
      },
      // ... 4 more questions
    ],
    "fill": []
  },
  "message": "Quiz generated successfully",
  "details": {
    "topic": "Photosynthesis",
    "num_questions": 5,
    "total_mcq": 5
  }
}
```

**Checklist**:
- [ ] API returns 200 OK
- [ ] Response has `success: true`
- [ ] Quiz has exactly 5 MCQ questions
- [ ] Each question has question, options, and answer fields
- [ ] Options array has 4 items

### Test via Node.js Gateway
```powershell
curl -X POST http://localhost:3000/api/generate-quiz `
  -H "Content-Type: application/json" `
  -d '{"topic":"Machine Learning"}'
```

**Checklist**:
- [ ] Node server forwards request to FastAPI
- [ ] Response contains quiz data
- [ ] No errors in Node.js console

---

## Test 3: Extension UI Test (Google Meet)

### Setup
1. Open Google Meet: https://meet.google.com/new
2. Join with 2+ accounts (or invite others)
3. Open browser console (F12)
4. Verify extension overlay appears

### Visual Check
- [ ] ClassBoost overlay visible in bottom-right
- [ ] All 4 buttons present:
  - Engagement Meter
  - Pair & Post Chat Links
  - Generate GIF
  - Generate Flashcard
- [ ] No console errors

---

## Test 4: Complete Quiz Generation Flow

### Step-by-Step Test

1. **Click "Pair & Post Chat Links"**
   - [ ] Topic modal appears
   - [ ] Input field is focused
   - [ ] "Submit" and "Cancel" buttons visible

2. **Enter Topic: "Python Programming"**
   - [ ] Type into input field
   - [ ] Click "Submit"
   - [ ] Modal closes

3. **Check Console (F12)**
   - [ ] `[ContentScript] Matched matchQuiz, calling executeMatchQuiz...`
   - [ ] `[ContentScript] Sending generateQuiz message to background...`
   - [ ] `[Background] generateQuiz handler triggered`
   - [ ] `[Background] Quiz generated with 5 questions`
   - [ ] No errors

4. **Check Background Service Worker**
   - Open `chrome://extensions/`
   - Click "Service worker" link on your extension
   - Check logs for:
     - [ ] `generateQuiz handler triggered for topic: Python Programming`
     - [ ] `Fetch response status: 200`
     - [ ] `Quiz generated with 5 questions, broadcasting to tabs...`

5. **Check Node.js Terminal**
   - [ ] `[generateQuiz] Received request for topic: Python Programming`
   - [ ] `[generateQuiz] Calling quiz generator at http://localhost:9000/generate-quiz`
   - [ ] `[generateQuiz] Quiz generated successfully with 5 questions`

6. **Check FastAPI Terminal**
   - [ ] POST request to `/generate-quiz`
   - [ ] 200 OK response

7. **Check Participant Pairing**
   - [ ] Temporary message: "✅ Quiz generated! Pairing students..."
   - [ ] System detects participants in Meet
   - [ ] Console shows: `Found X participants. Creating pairs...`

8. **Check Quiz Creation in Django**
   - Console should show:
     - [ ] `Quiz to send to Django: {...}`
     - [ ] `Quiz {id} created for pair 1`
     - [ ] `Quiz {id} created for pair 2` (if multiple pairs)

9. **Check Django Terminal**
   - [ ] POST requests to `/api/quiz/create/`
   - [ ] 201 Created responses

10. **Check Google Meet Chat**
    - [ ] Chat message posted automatically
    - [ ] Format: `📚 Pair Assignments - Python Programming Quiz:`
    - [ ] Each pair has a link: `Name1 & Name2: http://127.0.0.1:8000/chat/{roomId}?quiz={quizId}`
    - [ ] Links are clickable

11. **Click a Chat Link**
    - [ ] Opens Django chat page
    - [ ] URL includes `quiz={quizId}` parameter
    - [ ] Quiz interface loads

12. **Answer Quiz Questions**
    - [ ] 5 questions displayed
    - [ ] 4 options per question
    - [ ] Can select answers
    - [ ] Submit button works
    - [ ] Score calculated

---

## Test 5: Database Verification

### Check Django Database
```powershell
cd final_SyncSolve-fe39ef375cc20aac6fb95dcfbfae2da8452cd99e
.\.venv\Scripts\Activate.ps1
python manage.py shell
```

```python
from core.models import Quiz, CompetitiveSession

# Check created quizzes
quizzes = Quiz.objects.all()
print(f"Total quizzes: {quizzes.count()}")

# Check latest quiz
latest_quiz = Quiz.objects.latest('id')
print(f"Latest quiz: {latest_quiz.title}")
print(f"Questions: {len(latest_quiz.questions)}")

# Check competitive sessions
sessions = CompetitiveSession.objects.all()
print(f"Total sessions: {sessions.count()}")
```

**Checklist**:
- [ ] Quizzes created successfully
- [ ] Each quiz has 5 questions
- [ ] Questions have correct format
- [ ] Competitive sessions created

---

## Test 6: Error Handling

### Test Missing API Key
1. Temporarily remove GEMINI_API_KEY from quiz_generator_2/.env
2. Restart FastAPI service
3. Try to generate quiz

**Expected**:
- [ ] Service fails to start OR
- [ ] Error message about missing API key
- [ ] Extension shows user-friendly error

### Test Service Offline
1. Stop FastAPI service (port 9000)
2. Try to generate quiz from extension

**Expected**:
- [ ] Extension shows error: "Quiz generation failed"
- [ ] Console shows connection error
- [ ] No crashes

### Test Invalid Topic
1. Enter empty topic ""
2. Click Submit

**Expected**:
- [ ] Error message: "Please enter a topic"
- [ ] Modal stays open

---

## Test 7: Multiple Users Test

### Setup
1. Open Meet in 2+ Chrome windows (different accounts)
2. Load extension in all windows

### Test Flow
1. Teacher (window 1) clicks "Pair & Post Chat Links"
2. Enter topic
3. Check that chat message appears in ALL windows
4. Students (windows 2+) click their assigned links
5. Each student sees their quiz

**Checklist**:
- [ ] All participants see chat message
- [ ] Links are unique per pair
- [ ] Each pair gets different quiz ID
- [ ] Students can access their assigned chat room
- [ ] Scores tracked independently

---

## Test 8: Performance Test

### Metrics to Check
- [ ] Quiz generation time < 10 seconds
- [ ] Pairing algorithm completes instantly
- [ ] Chat message posts within 2 seconds
- [ ] No memory leaks (check Task Manager)
- [ ] Browser remains responsive

---

## Common Issues & Solutions

### Issue: "Quiz generation failed"
**Check**:
1. FastAPI service running on port 9000?
2. GEMINI_API_KEY set correctly?
3. Network logs show request to localhost:9000?

### Issue: "No participants found"
**Check**:
1. At least 2 people in Meet?
2. Participant panel visible in Meet?
3. Console shows participant detection logs?

### Issue: "Quiz not created in Django"
**Check**:
1. Django running on port 8000?
2. Database migrated?
3. CORS enabled in Django settings?
4. Network logs show POST to localhost:8000?

### Issue: Chat message not posted
**Check**:
1. Chat panel open in Meet?
2. Meet chat input field accessible?
3. Console shows "postToChat" logs?

---

## Final Checklist

### Before Deployment
- [ ] All services start without errors
- [ ] Quiz generation works consistently
- [ ] Participant pairing works correctly
- [ ] Chat links are posted successfully
- [ ] Students can access quiz platform
- [ ] Scores are tracked and stored
- [ ] Extension handles errors gracefully
- [ ] Documentation is complete
- [ ] README and SETUP_GUIDE are updated

### Code Quality
- [ ] No console errors in normal operation
- [ ] Proper error messages shown to users
- [ ] All API calls have timeout handling
- [ ] Extension handles service disconnections
- [ ] Database connections are stable

---

## Success Criteria

✅ **Complete Integration Success** when:
1. Click button → Topic modal appears
2. Enter topic → AI generates 5 MCQs
3. System pairs participants automatically
4. Chat links posted to Google Meet
5. Students click links → Django chat opens
6. Students answer quiz → Scores tracked
7. Winners determined → Results stored

---

## Testing Log

Date: ___________
Tester: ___________

| Test | Status | Notes |
|------|--------|-------|
| Service Health | ⬜ | |
| Quiz Generation API | ⬜ | |
| Extension UI | ⬜ | |
| Complete Flow | ⬜ | |
| Database Verification | ⬜ | |
| Error Handling | ⬜ | |
| Multiple Users | ⬜ | |
| Performance | ⬜ | |

**Overall Status**: ⬜ Pass / ⬜ Fail

**Notes**:
_______________________________________________
_______________________________________________
_______________________________________________
