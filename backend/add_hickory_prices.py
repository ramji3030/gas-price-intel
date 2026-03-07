#!/usr/bin/env python3
"""
Script to add Hickory, NC gas station prices to the database
Run this to populate your dashboard with real data!
"""

import requests
from datetime import datetime

# API endpoint
BASE_URL = "http://localhost:8000/api/v1"

# Hickory, NC gas stations data
stations = [
    {
        "name": "Murphy USA",
        "address": "140 US-321, Hickory, NC",
        "phone": "(828) 419-7455",
        "price": 3.00,
        "station_id": "MURPHY_USA_140"
    },
    {
        "name": "RaceWay",
        "address": "1230 US-321, Hickory, NC",
        "phone": "(828) 838-1288",
        "price": 3.40,
        "station_id": "RACEWAY_1230"
    }
]

def add_price(station):
    """
    Add a price record for a station
    """
    print(f"\n📍 Adding price for {station['name']}...")
    print(f"   Address: {station['address']}")
    print(f"   Price: ${station['price']}/gallon")
    
    # Add price via API
    try:
        response = requests.post(
            f"{BASE_URL}/prices/manual",
            json={
                "station_id": station['station_id'],
                "price": station['price'],
                "fuel_type": "regular",
                "source": "manual_entry"
            }
        )
        
        if response.status_code == 200:
            print(f"   ✅ Success! Price added")
            return True
        else:
            print(f"   ❌ Error: {response.text}")
            return False
    except Exception as e:
        print(f"   ❌ Failed: {e}")
        return False

def main():
    print("🚀 Adding Hickory, NC Gas Prices to Database")
    print("="*50)
    
    success_count = 0
    
    for station in stations:
        if add_price(station):
            success_count += 1
    
    print("\n" + "="*50)
    print(f"\n✨ Done! Added {success_count}/{len(stations)} stations")
    print("\n💡 Now refresh your dashboard at http://localhost:3000")
    print("\n📊 You should see:")
    print(f"   • Murphy USA: $3.00 (BEST PRICE! 💰)")
    print(f"   • RaceWay: $3.40")
    print(f"   • Savings: $0.40/gallon at Murphy USA")
    print("\n" + "="*50)

if __name__ == "__main__":
    main()
