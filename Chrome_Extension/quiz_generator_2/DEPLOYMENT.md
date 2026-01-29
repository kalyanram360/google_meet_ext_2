# Deployment Guide

## Deploy FastAPI to Render.com

1. **Push code to GitHub**
   ```bash
   git init
   git add .
   git commit -m "Quiz generator API"
   git branch -M main
   git remote add origin YOUR_GITHUB_REPO_URL
   git push -u origin main
   ```

2. **Deploy on Render**
   - Go to https://render.com
   - Sign up/Login with GitHub
   - Click "New" → "Web Service"
   - Connect your GitHub repository
   - Configure:
     - **Name**: quiz-generator-api
     - **Environment**: Python 3
     - **Build Command**: `pip install -r requirements.txt`
     - **Start Command**: `uvicorn api_server:app --host 0.0.0.0 --port $PORT`
   - Add Environment Variable:
     - **Key**: `GEMINI_API_KEY`
     - **Value**: Your API key
   - Click "Create Web Service"

3. **Your API URL**: `https://quiz-generator-api.onrender.com`

## Deploy Streamlit App (Optional)

1. Go to https://share.streamlit.io
2. Connect GitHub repo
3. Select `app.py`
4. Add secret in Settings:
   ```toml
   GEMINI_API_KEY = "your_key_here"
   ```
5. Deploy

## Test API

```bash
curl -X POST "https://your-app.onrender.com/generate-quiz" \
  -H "Content-Type: application/json" \
  -d '{"topic":"Python"}'
```

## Alternative: Railway.app

1. Go to https://railway.app
2. "New Project" → "Deploy from GitHub"
3. Select repo
4. Add `GEMINI_API_KEY` environment variable
5. Deploy automatically detects FastAPI

Your API will be at: `https://your-app.railway.app`
