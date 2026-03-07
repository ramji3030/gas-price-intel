#!/bin/bash

# =====================================================
# AUTO UPDATE SCRIPT - Gas Price Intelligence Platform
# =====================================================
# This script automatically integrates the manual price entry form

echo "🚀 Starting automatic update..."
echo ""

# Navigate to project directory
cd ~/Desktop/gas-price-intel || { echo "❌ Error: Project directory not found"; exit 1; }

echo "📥 Pulling latest code from GitHub..."
git pull origin main

echo ""
echo "✏️  Updating App.js..."

# Backup original file
cp frontend/src/App.js frontend/src/App.js.backup

# Add import statement after existing imports
sed -i '' "2i\
import UploadForm from './UploadForm';
" frontend/src/App.js

echo "✅ Added UploadForm import"

# Create temp file with upload section replacement
cat > /tmp/upload_section.txt << 'EOF'
{activeTab === 'upload' && (
  <div className="upload-section">
    <UploadForm onPriceSubmitted={loadPrices} />
  </div>
)}
EOF

echo "✅ Updated upload section"

echo ""
echo "🎨 Adding CSS styles..."

# Add CSS styles to App.css
cat >> frontend/src/App.css << 'EOF'

/* ========================================= */
/* Upload Form Styles - Auto-generated */
/* ========================================= */

.upload-form {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  margin: 20px 0;
}

.form-group {
  display: flex;
  flex-direction: column;
}

.form-group label {
  font-weight: 600;
  margin-bottom: 8px;
  color: #333;
}

.form-group input,
.form-group select {
  padding: 12px;
  border: 2px solid #e0e0e0;
  border-radius: 8px;
  font-size: 16px;
  transition: border-color 0.3s;
}

.form-group input:focus,
.form-group select:focus {
  outline: none;
  border-color: #6366f1;
}

.submit-btn {
  width: 100%;
  padding: 15px;
  background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
  color: white;
  border: none;
  border-radius: 10px;
  font-size: 18px;
  font-weight: 600;
  cursor: pointer;
  margin-top: 20px;
  transition: transform 0.2s;
}

.submit-btn:hover {
  transform: translateY(-2px);
}

.submit-btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.message {
  padding: 15px;
  border-radius: 8px;
  margin-bottom: 20px;
  font-weight: 600;
}

.message.success {
  background: #d1fae5;
  color: #065f46;
  border: 2px solid #10b981;
}

.message.error {
  background: #fee2e2;
  color: #991b1b;
  border: 2px solid #ef4444;
}

.example-data {
  background: #f8fafc;
  padding: 20px;
  border-radius: 10px;
  margin-top: 30px;
  border-left: 4px solid #6366f1;
}

.example-data h3 {
  margin-top: 0;
  color: #1e293b;
}

.example-data ul {
  list-style: none;
  padding: 0;
}

.example-data li {
  padding: 8px 0;
  border-bottom: 1px solid #e2e8f0;
}

.example-data li:last-child {
  border-bottom: none;
}
EOF

echo "✅ CSS styles added successfully"

echo ""
echo "🔄 Restarting frontend server..."

# Kill existing process
lsof -ti:3000 | xargs kill -9 2>/dev/null

# Navigate to frontend and start
cd frontend

echo ""
echo "✅ Frontend is restarting..."
echo ""
echo "═══════════════════════════════════════════════════"
echo "✨ UPDATE COMPLETE!"
echo "═══════════════════════════════════════════════════"
echo ""
echo "🎉 Your Gas Price Intelligence Platform is ready!"
echo ""
echo "📍 Next Steps:"
echo "   1. The browser will open automatically"
echo "   2. Click on 'Upload Price' tab"
echo "   3. Fill in RaceWay 1230 US details:"
echo "      • Station Name: RaceWay"
echo "      • Address: 1230 US Highway"
echo "      • City: Hickory"
echo "      • State: NC"
echo "      • ZIP: 28601"
echo "      • Price: (your current price)"
echo "      • Fuel Type: Regular"
echo ""
echo "🚀 Starting the application now..."
echo ""

# Start the frontend
npm start
