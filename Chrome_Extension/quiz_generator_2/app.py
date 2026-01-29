import os
from dotenv import load_dotenv
import streamlit as st
import json
from modules.quiz_generator import generate_quiz

# Load environment variables
if os.path.exists('.env'):
    load_dotenv()

# Check for API key
api_key = os.environ.get("GEMINI_API_KEY")
if not api_key:
    st.error("❌ Missing GEMINI_API_KEY in .env file")
    st.stop()

st.set_page_config("Quiz Generator", page_icon="🧠")
st.title("🧠 Quiz Generator")

topic = st.text_input("📘 Enter Topic", placeholder="e.g., Photosynthesis")

if st.button("⚡ Generate Quiz", type="primary"):
    if not topic:
        st.error("❌ Please enter a topic.")
        st.stop()

    with st.spinner("Generating 5 quiz questions..."):
        try:
            quiz_func = generate_quiz(topic, api_key, num_mcq=5, num_fill=0, difficulty="Medium")
            quiz = quiz_func("", num_options=4)
            
            st.success("✅ Quiz generated!")
            
            for i, q in enumerate(quiz.get("mcq", []), 1):
                st.markdown(f"**Q{i}. {q['question']}**")
                for opt in q['options']:
                    st.markdown(f"- {opt}")
                with st.expander(f"Answer"):
                    st.success(f"✓ {q['answer']}")
                st.markdown("---")
            
            st.download_button(
                "📥 Download JSON",
                data=json.dumps(quiz, indent=2),
                file_name=f"quiz_{topic.replace(' ', '_')}.json",
                mime="application/json"
            )
            
        except Exception as e:
            st.error(f"❌ Error: {str(e)}")
