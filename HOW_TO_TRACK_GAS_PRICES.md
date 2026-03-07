# How to Track Gas Prices with Gas Price Intelligence Platform

## 🚀 Quick Start Guide

### Step 1: Start the Application

```bash
# Navigate to your project directory
cd ~/Desktop/gas-price-intel

# Pull latest changes
git pull origin main

# Make the start script executable
chmod +x START_APP.sh

# Run the application
./START_APP.sh
```

The script will automatically:
- Kill any existing processes on ports 3000 and 8000
- Start the backend API server (port 8000)
- Start the frontend dashboard (port 3000)
- Open your browser to http://localhost:3000

---

## 📍 Track Gas Prices at Specific Stations

### Example: RaceWay 1230 US

To track gas prices at a specific station:

1. **Navigate to "Upload Price" tab**
2. **Fill in Station Details:**
   - Station Name: RaceWay
   - Address: 1230 US Highway (your specific address)
   - City: [Your City]
   - State: [Your State]
   - ZIP: [Your ZIP]

3. **Submit Price Data:**
   - Enter current gas price (e.g., $3.40)
   - Select fuel type (Regular/Premium/Diesel)
   - Add optional photo of price sign
   - Click "Submit Price"

4. **View Analytics:**
   - Go to "Analytics" tab
   - See price trends and competitor comparisons
   - Track market position

---

## 🎯 Core Features

### 1. Dashboard View
- Real-time current price
- Competitor average pricing
- Market position (1st, 2nd, 3rd, etc.)
- Price update count
- Recent price history

### 2. Upload Price
- Manual price entry
- Photo upload with OCR detection
- Location tracking
- Timestamp verification

### 3. Analytics
- Price trend charts
- Competitor comparisons
- Best pricing recommendations
- Historical data analysis

---

## 📊 API Endpoints

Base URL: `http://localhost:8000`

### Submit Price
```bash
POST /api/prices/
{
  "station_name": "RaceWay",
  "address": "1230 US Highway",
  "city": "YourCity",
  "state": "YourState",
  "zip_code": "12345",
  "price": 3.40,
  "fuel_type": "regular"
}
```

### Get Price History
```bash
GET /api/prices/history?station_id=1
```

### Get Analytics
```bash
GET /api/analytics/station/1
```

---

## 🔧 Troubleshooting

### Port Already in Use
If you see "Port already in use" errors:
```bash
# Kill processes manually
lsof -ti:3000 | xargs kill -9
lsof -ti:8000 | xargs kill -9
```

### Database Issues
```bash
# Reset database
cd backend
rm -f gas_prices.db
python3 -m uvicorn main:app --reload
```

### Frontend Not Loading
```bash
cd frontend
rm -rf node_modules
npm install
npm start
```

---

## 📱 Mobile Access

Access from your phone on the same network:
1. Find your computer's IP address: `ifconfig | grep inet`
2. Open browser on phone: `http://YOUR_IP:3000`

---

## 🎨 Customization

### Add Your Station Logo
1. Place logo in `frontend/public/logo.png`
2. Restart frontend

### Change Colors
Edit `frontend/src/App.js` - Look for color definitions

---

## 📈 Best Practices

1. **Update Prices Regularly**: At least 2-3 times per day
2. **Add Photos**: Helps verify price accuracy
3. **Track Competitors**: Add nearby gas stations
4. **Monitor Trends**: Check analytics daily
5. **Adjust Pricing**: Use data to stay competitive

---

## 🌟 Next Steps

1. **Add More Stations**: Track all competitors in your area
2. **Set Price Alerts**: Get notified of competitor changes
3. **Export Data**: Download reports for analysis
4. **Share Access**: Invite team members

---

## 💡 Tips for RaceWay 1230 US

1. Set up station profile with exact address
2. Add 3-5 competitor stations nearby
3. Update prices at peak hours (morning, evening)
4. Monitor weekend vs weekday patterns
5. Track seasonal trends

---

## 🆘 Support

For issues or questions:
- Check GitHub Issues
- Review API documentation at http://localhost:8000/docs
- Check logs in terminal

---

## 🚀 Production Deployment (Coming Soon)

- AWS hosting
- Mobile app
- SMS alerts
- Multi-user support
- Advanced analytics
