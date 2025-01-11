#!/usr/bin/env python3
import requests
import json
from datetime import datetime
import sys
import os
from pathlib import Path

def load_cache():
    cache_file = Path.home() / '.cache' / 'prayer_times.json'
    if cache_file.exists():
        try:
            with open(cache_file) as f:
                return json.load(f)
        except:
            return None
    return None

def save_cache(data):
    cache_file = Path.home() / '.cache' / 'prayer_times.json'
    # Ensure cache directory exists
    cache_file.parent.mkdir(parents=True, exist_ok=True)
    
    with open(cache_file, 'w') as f:
        json.dump(data, f)

def should_update_cache(cached_data):
    if not cached_data:
        return True
        
    # Check if we have data for today
    today = datetime.now().strftime("%Y-%-m-%-d")
    has_today = any(item['date_for'] == today for item in cached_data.get('items', []))
    
    # If we don't have today's data, we need to update
    return not has_today

def get_prayer_times():
    try:
        # Load cached data
        cached_data = load_cache()
        
        # Check if we need to update the cache
        if should_update_cache(cached_data):
            response = requests.get('https://muslimsalat.com/depok/weekly.json')
            data = response.json()
            
            if data['status_code'] != 1:
                return "API Error"
                
            # Save new data to cache
            save_cache(data)
        else:
            data = cached_data
            
        today = datetime.now().strftime("%Y-%-m-%-d")
        today_prayers = next((item for item in data['items'] if item['date_for'] == today), None)
        
        if not today_prayers:
            return "No data"
            
        current_time = datetime.now()
        
        # Convert prayer times to 24-hour format for comparison
        times = {
            'Fajr': datetime.strptime(today_prayers['fajr'], "%I:%M %p").strftime("%H:%M"),
            'Dhuhr': datetime.strptime(today_prayers['dhuhr'], "%I:%M %p").strftime("%H:%M"),
            'Asr': datetime.strptime(today_prayers['asr'], "%I:%M %p").strftime("%H:%M"),
            'Maghrib': datetime.strptime(today_prayers['maghrib'], "%I:%M %p").strftime("%H:%M"),
            'Isha': datetime.strptime(today_prayers['isha'], "%I:%M %p").strftime("%H:%M")
        }
        
        # Find next prayer
        current_time_str = current_time.strftime("%H:%M")
        next_prayer = None
        
        for prayer, time in times.items():
            if time > current_time_str:
                next_prayer = f"{prayer}: {time}"
                break
        
        if not next_prayer:
            # Try to get tomorrow's Fajr time
            tomorrow_prayers = next((item for item in data['items'] 
                                  if datetime.strptime(item['date_for'], "%Y-%-m-%-d") > 
                                     datetime.strptime(today, "%Y-%-m-%-d")), None)
            if tomorrow_prayers:
                fajr_time = datetime.strptime(tomorrow_prayers['fajr'], "%I:%M %p").strftime("%H:%M")
                next_prayer = f"Tomorrow's Fajr: {fajr_time}"
            else:
                next_prayer = f"Tomorrow's Fajr: {times['Fajr']}"
            
        return next_prayer
        
    except Exception as e:
        return f"Error: {str(e)}"

if __name__ == "__main__":
    print(get_prayer_times())
