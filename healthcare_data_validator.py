
#CSV files from providers often have missing fields or "junk" data that breaks the system.
# A Python script using pandas that cleans a "dirty" healthcare record file.
import pandas as pd

def clean_patient_data(file_path):
    # Load messy data
    df = pd.read_csv(file_path)
    
    # 1. Flag missing Patient IDs
    missing_ids = df[df['patient_id'].isnull()]
    
    # 2. Standardize phone numbers or dates
    df['phone'] = df['phone'].str.replace(r'\D', '', regex=True)
    
    # 3. Export a "Clean" file and an "Error" log for the client
    df.dropna(subset=['patient_id']).to_csv('clean_data.csv', index=False)
    missing_ids.to_csv('error_log_for_client.csv', index=False)
    
    print(f"Audit Complete. {len(missing_ids)} errors found and logged.")
