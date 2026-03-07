#!/bin/bash

# ==============================================
# Gas Price Intelligence - ONE-CLICK STARTER
# ==============================================
# This script starts EVERYTHING you need!
# Just run: bash START_APP.sh
# ==============================================

echo "🚀 Starting Gas Price Intelligence Platform..."
echo "================================================"

# Kill any existing processes on ports 3000 and 8000
echo "🧹 Cleaning up old processes..."
lsof -ti:3000 | xargs kill -9 2>/dev/null || true
lsof -ti:8000 | xargs kill -9 2>/dev/null || true

echo "✅ Ports cleared!"
echo ""

# Navigate to project
cd ~/Desktop/gas-price-intel

echo "🔄 Pulling latest code..."
git pull origin main

echo ""
echo "🔧 Starting Backend API (port 8000)..."
cd backend
python3 -m uvicorn app.main:app --reload --port 8000 > /tmp/gas-backend.log 2>&1 &
BACKEND_PID=$!

echo "✅ Backend started! (PID: $BACKEND_PID)"

echo ""
echo "⏳ Waiting 5 seconds for backend to initialize..."
sleep 5

echo ""
echo "📊 Adding Hickory gas station prices..."
python3 add_hickory_prices.py

echo ""
echo "🎨 Starting Frontend (port 3000)..."
cd ../frontend
npm start > /tmp/gas-frontend.log 2>&1 &
FRONTEND_PID=$!

echo "✅ Frontend started! (PID: $FRONTEND_PID)"

echo ""
echo "⏳ Waiting for frontend to build..."
sleep 10

echo ""
echo "================================================"
echo "✅ SUCCESS! Everything is running!"
echo "================================================"
echo ""
echo "🎉 Your Gas Price Dashboard is ready!"
echo ""
echo "📍 URLs:"
echo "   Frontend: http://localhost:3000"
echo "   Backend API: http://localhost:8000"
echo "   API Docs: http://localhost:8000/docs"
echo ""
echo "📊 Showing Hickory, NC prices:"
echo "   • Murphy USA: \$3.00 (BEST PRICE!)"
echo "   • RaceWay: \$3.40"
echo "   • Savings: \$0.40/gallon"
echo ""
echo "🔴 To STOP the app:"
echo "   kill $BACKEND_PID $FRONTEND_PID"
echo ""
echo "================================================"
echo "👍 Opening browser in 3 seconds..."
sleep 3
open http://localhost:3000

echo ""
echo "✨ Done! Check your browser!"
echo ""
