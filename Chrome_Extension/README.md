# ClassBoost Chrome Extension

This folder contains the Chrome extension files for ClassBoost.

## Installation

1. Open Chrome and navigate to `chrome://extensions/`
2. Enable **Developer mode** (toggle in top right)
3. Click **Load unpacked**
4. Select **this folder** (`Extension`)

## Files

- **manifest.json** - Extension configuration
- **background.js** - Background service worker (handles API calls)
- **content.js** - Content script (UI overlay in Google Meet)
- **overlay.css** - Styling for the overlay UI

## Requirements

Before loading the extension, make sure all backend services are running:
- Node.js Server (port 3000)
- FastAPI Quiz Generator (port 9000)
- Django Backend (port 8000)

Run `start_all_services.ps1` from the project root to start all services.

## Features

- 🤖 AI-powered quiz generation
- 📇 Educational flashcard generation
- 🎬 GIF search
- 📊 Real-time engagement tracking
- 👥 Student pairing for competitions

For more details, see the main [README.md](../README.md) in the project root.
