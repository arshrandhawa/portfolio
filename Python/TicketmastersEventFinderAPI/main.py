#!/usr/bin/env python
# coding: utf-8

# In[1]:


#!/usr/bin/env python
# coding: utf-8

import os
from dotenv import load_dotenv
from fastapi import FastAPI
import requests
import pandas as pd



# In[ ]:


# Change working directory to the correct one
project_path = os.getcwd()  # Get the current working directory inside the container
print(f"Project Path: {project_path}")  # Debugging


# Load environment variables
load_dotenv()

# Retrieve SECRET_KEY
SECRET_KEY = os.getenv('SECRET_KEY')


# In[35]:


from fastapi import FastAPI
import requests


app = FastAPI()

API_KEY = SECRET_KEY
BASE_URL = "https://app.ticketmaster.com/discovery/v2/events.json"

@app.get("/events/")
def get_events(city: str):
    params = {
        "apikey": API_KEY,
        "city": city
    }
    response = requests.get(BASE_URL, params=params)
    data = response.json()
    
    if "_embedded" in data:
        events = data["_embedded"]["events"]
        return [
            {
                "name": event["name"],
                "date": event["dates"]["start"]["localDate"],
                "venue": event["_embedded"]["venues"][0]["name"],
                "url": event["url"],
                "price_min": event["priceRanges"][0]["min"],
                "price_max": event["priceRanges"][0]["max"]
            }
            for event in events

        ]
    else:
        return {"message": "No events found"}



# In[37]:


# Testing if get_events is working corrected and evaluate the format of the data 
#get_events("Chandler")


# In[38]:


import pandas as pd

def print_events_pandas(events, city):
    if not events:
        print(f"No events found in {city}.")
        return

    formatted_events = []
    for event in events:
        formatted_events.append({
            "Venue": event["venue"],
            "Event Name": event["name"],
            "Date": event["date"],
            "Price Range": f'{event["price_min"]}-{event["price_max"]}'
        })

    # Convert to pandas DataFrame
    df = pd.DataFrame(formatted_events)
    df.index += 1  # Start index from 1 for readability

    #For better readibility, group the output by venue and print Event, Date, and Price Range
    print(f"\nEvents in {city}:")
    for venue in df["Venue"].unique():
        venue_events = df[df["Venue"] == venue]
        print(f"\nVenue: {venue}")
        print(venue_events[["Event Name", "Date", "Price Range"]].to_string(index=False))



# In[39]:


city_name = "Chandler"
events = get_events(city_name)  # Fetch events from Ticketmaster API

print_events_pandas(events, city_name)  # Display output using pandas

