#A client claims their patient payment portal is "slow" or "not working." 
#you run this script to prove exactly where the connection is failing.

import requests
import time

# List of Cedar-mock endpoints to test
ENDPOINTS = {
    "Patient Login": "https://api.cedar_mock.com/v1/auth",
    "Payment Processing": "https://api.cedar_mock.com/v1/payments",
    "Insurance Eligibility": "https://api.cedar_mock.com/v1/insurance"
}

def check_system_health():
    print(f"--- Starting API Connectivity Audit ---")
    for service, url in ENDPOINTS.items():
        start_time = time.time()
        try:
            # We use a 5-second timeout to catch latency issues
            response = requests.get(url, timeout=5)
            latency = round((time.time() - start_time) * 1000, 2)
            
            if response.status_code == 200:
                print(f"✅ {service}: SUCCESS ({latency}ms)")
            else:
                print(f"⚠️ {service}: FAILED (Status: {response.status_code})")
        except requests.exceptions.RequestException as e:
            print(f"❌ {service}: UNREACHABLE (Error: {e})")

if __name__ == "__main__":
    check_system_health()
