"""Gas Price Intelligence SaaS Platform - Main Application"""
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime
import os

# App configuration
app = FastAPI(
    title="Gas Price Intelligence API",
    version="1.0.0",
    description="Real-time gas price intelligence platform with OCR detection and analytics",
    docs_url="/api/docs",
    openapi_url="/api/openapi.json"
)

# CORS middleware
allowed_origins = os.getenv("ALLOWED_ORIGINS", "http://localhost:3000").split(",")
app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Pydantic models
class Station(BaseModel):
    id: Optional[int] = None
    name: str
    brand: str
    address: str
    lat: float
    lng: float
    active: bool = True

class PriceReport(BaseModel):
    id: Optional[int] = None
    station_id: int
    fuel_type: str  # REGULAR, PREMIUM, DIESEL
    price: float
    reported_at: datetime
    source: str = "manual"  # manual, image, api

# In-memory storage (replace with database later)
stations_db = []
prices_db = []

# Root endpoints
@app.get("/")
def root():
    return {
        "message": "Gas Price Intelligence API v1.0",
        "status": "operational",
        "docs": "/api/docs",
        "health": "/health"
    }

@app.get("/health")
def health_check():
    return {
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat(),
        "version": "1.0.0"
    }

# Station endpoints
@app.get("/api/v1/stations", response_model=List[Station])
def list_stations():
    """Get all gas stations"""
    return stations_db

@app.post("/api/v1/stations", response_model=Station, status_code=201)
def create_station(station: Station):
    """Create a new gas station"""
    station.id = len(stations_db) + 1
    stations_db.append(station)
    return station

@app.get("/api/v1/stations/{station_id}", response_model=Station)
def get_station(station_id: int):
    """Get station by ID"""
    for station in stations_db:
        if station.id == station_id:
            return station
    raise HTTPException(status_code=404, detail="Station not found")

# Price endpoints
@app.get("/api/v1/prices")
def list_prices(station_id: Optional[int] = None):
    """Get all price reports"""
    if station_id:
        return [p for p in prices_db if p.station_id == station_id]
    return prices_db

@app.post("/api/v1/prices", status_code=201)
def report_price(price_report: PriceReport):
    """Report a new gas price"""
    price_report.id = len(prices_db) + 1
    price_report.reported_at = datetime.utcnow()
    prices_db.append(price_report)
    return {
        "id": price_report.id,
        "message": "Price reported successfully",
        "price_report": price_report
    }

# Image upload endpoint (stub for now)
@app.post("/api/v1/uploads/image")
def upload_image():
    """Upload and process gas price board image"""
    return {
        "message": "Image upload endpoint - OCR processing coming soon",
        "status": "stub"
    }

# Analytics endpoint
@app.get("/api/v1/analytics/summary")
def get_analytics():
    """Get price analytics summary"""
    return {
        "total_stations": len(stations_db),
        "total_prices": len(prices_db),
        "last_updated": datetime.utcnow().isoformat()
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
