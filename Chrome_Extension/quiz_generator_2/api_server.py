"""
FastAPI for Quiz Generator
Provides POST endpoint to generate quiz questions as JSON
"""
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import os
from dotenv import load_dotenv
from modules.quiz_generator import generate_quiz

# Load environment variables
if os.path.exists('.env'):
    load_dotenv()

# Check required environment variables
REQUIRED_KEYS = ["GEMINI_API_KEY"]
for key in REQUIRED_KEYS:
    if not os.environ.get(key):
        raise EnvironmentError(f"Missing required environment variable: {key}")

app = FastAPI(title="Quiz Generator API", version="2.0.0")

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins for testing
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class QuizRequest(BaseModel):
    topic: str = Field(..., min_length=1, description="Quiz topic")

class QuizResponse(BaseModel):
    success: bool
    quiz: dict
    message: str
    details: dict

@app.get("/")
async def root():
    """Root endpoint"""
    return {
        "message": "Quiz Generator API",
        "version": "2.0.0",
        "endpoints": {
            "/health": "Health check",
            "/generate-quiz": "Generate quiz questions (POST)"
        }
    }

@app.get("/health")
async def health_check():
    """Health check endpoint"""
    return {"status": "healthy"}

@app.post("/generate-quiz", response_model=QuizResponse)
async def generate_quiz_endpoint(request: QuizRequest):
    """
    Generate 5 quiz questions based on topic
    
    Request body:
    - topic: Quiz topic (required)
    
    Returns 5 quiz questions in JSON format
    """
    try:
        # Generate quiz - always 5 questions, medium difficulty
        api_key = os.environ.get("GEMINI_API_KEY")
        
        # Generate quiz (5 MCQs)
        quiz_func = generate_quiz(
            topic=request.topic,
            api_key=api_key,
            num_mcq=5,
            num_fill=0,
            difficulty="Medium"
        )
        quiz = quiz_func("", num_options=4)
        
        return QuizResponse(
            success=True,
            quiz=quiz,
            message="Quiz generated successfully",
            details={
                "topic": request.topic,
                "num_questions": 5,
                "difficulty": "Medium",
                "total_mcq": len(quiz.get("mcq", [])),
                "total_fill": len(quiz.get("fill", []))
            }
        )
        
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Failed to generate quiz: {str(e)}"
        )

if __name__ == '__main__':
    import uvicorn
    port = int(os.environ.get('PORT', 8000))
    uvicorn.run(app, host='0.0.0.0', port=port)
