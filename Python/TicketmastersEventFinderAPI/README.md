# 🎟️ TicketmastersEventFinderAPI

## 📌 Project Overview
TicketmastersEventFinderAPI is a Python-based API that interacts with the Ticketmaster API to fetch event details. Built using **FastAPI**, this project allows users to search for events based on city, retrieve event details, and display formatted output using **pandas**.

## 🚀 Features
- Search for events via the Ticketmaster API
- Retrieve event details such as venue, date, and price range
- Display results in a structured format using **pandas**
- Uses **FastAPI** for efficient API handling
- Loads API keys securely from a `.env` file
- Automatically installs required dependencies if missing

## 🛠️ Technologies Used
- **FastAPI** - High-performance API framework
- **Requests** - For making API calls to Ticketmaster
- **Pandas** - Data manipulation and formatting
- **Python-dotenv** - For managing environment variables

## 🔑 Setup & Installation
### **1. Clone the Repository**
```bash
git clone https://github.com/arshrandhawa/portfolio/tree/main/Python/TicketmastersEventFinderAPI.git
cd TicketmastersEventFinderAPI
```

### **2. Create a Virtual Environment**
```bash
python -m venv venv
source venv/bin/activate  # On macOS/Linux
venv\Scripts\activate  # On Windows
```

### **3. Install Dependencies**
You can skip this step if you're running the script, as it will automatically install any missing dependencies. However, if you prefer to manually install them, you can use the following command:
```bash
pip install fastapi requests pandas python-dotenv uvicorn
```

### **4. Set Up Environment Variables**
1. Create a `.env` file in the project root.
2. Add your **Ticketmaster API Key**:
```
SECRET_KEY=your_actual_ticketmaster_api_key
```

### **5. Run the API**
```bash
uvicorn main:app --reload
```

Your API will now be running at: `http://127.0.0.1:8000`

### **6. Test API Endpoints**
Open your browser and visit:
```bash
http://127.0.0.1:8000/docs
```
This will open the interactive Swagger UI to test endpoints.

## 📌 Example API Request
### **Search for Events by City**
```http
GET /events/?city=Chandler
```
**Response:**
```json
[
  {
    "name": "Concert XYZ",
    "date": "2025-03-15",
    "venue": "Staples Center",
    "url": "https://ticketmaster.com/event/123456",
    "price_min": 50,
    "price_max": 150
  }
]
```

## 📄 API Endpoints
| Method | Endpoint           | Description                  |
|--------|-------------------|------------------------------|
| GET    | `/events/`        | Fetch events by city        |

## 📊 Displaying Event Data with Pandas
To print event data in a structured format:
```python
from main import get_events, print_events_pandas
city_name = "Chandler"
events = get_events(city_name)  # Fetch events from Ticketmaster API
print_events_pandas(events, city_name)  # Display output using pandas
```

[You can see the sample here](https://github.com/arshrandhawa/portfolio/blob/main/Python/TicketmastersEventFinderAPI/TicketmastersEventFinderAPI_SampleResults.pdf)

## 📬 Connect With Me

- **LinkedIn**: [My LinkedIn Profile](https://www.linkedin.com/in/arshrandhawa11/)
- **Tableau Public**: [My Tableau Public Profile](https://public.tableau.com/app/profile/arshdeep.randhawa6351/vizzes)
- **Email**: [arshdip.randhawa@gmail.com](mailto:arshdip.randhawa@gmail.com)

Thank you for visiting my portfolio! Feel free to reach out for collaborations or opportunities.

