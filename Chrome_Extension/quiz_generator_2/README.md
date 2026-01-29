# Quiz Generator

Generate quiz questions using AI (Google Gemini) - deployable on Streamlit Cloud.

## Features

- 🧠 AI-powered quiz generation
- 📝 Always generates 5 MCQ questions
- 🌐 FastAPI backend + Streamlit frontend
- ☁️ Deploy to Streamlit Cloud

## Setup

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

### 2. Get Gemini API Key

1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create API key
3. Create `.env` file:

```env
GEMINI_API_KEY=your_api_key_here
```

## Run Locally

### Streamlit App
```bash
streamlit run app.py
```

### FastAPI Server
```bash
python api_server.py
```
Then visit: http://localhost:8000/docs

## API Usage

### POST /generate-quiz

**Request:**
```json
{
  "topic": "Photosynthesis"
}
```

**Response:**
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
    ],
    "fill": []
  },
  "message": "Quiz generated successfully",
  "details": {
    "topic": "Photosynthesis",
    "num_questions": 5,
    "difficulty": "Medium"
  }
}
```

## Deploy to Streamlit Cloud

1. Push code to GitHub
2. Go to [share.streamlit.io](https://share.streamlit.io)
3. Deploy `app.py`
4. Add `GEMINI_API_KEY` to Secrets in Streamlit settings

## Project Structure

```
quiz_generator_2/
├── app.py              # Streamlit app
├── api_server.py       # FastAPI server
├── requirements.txt    # Dependencies
├── .env               # Environment variables (local)
└── modules/
    ├── quiz_generator.py  # Quiz generation logic
    └── __init__.py
```
