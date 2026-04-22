# help a client who is struggling to get their daily billing files (EDI 837) into the system.

import paramiko
import os
import shutil

# Configuration
LOCAL_DIR = "./pending_claims"
ARCHIVE_DIR = "./processed_claims"
SFTP_HOST = "sftp.cedar.com"
SFTP_USER = "client_user"
SFTP_PASS = "your_secure_password"

def upload_files():
    # 1. Establish Connection
    transport = paramiko.Transport((SFTP_HOST, 22))
    transport.connect(username=SFTP_USER, password=SFTP_PASS)
    sftp = paramiko.SFTPClient.from_transport(transport)

    # 2. Scan for files
    files = [f for f in os.listdir(LOCAL_DIR) if f.endswith('.txt') or f.endswith('.edi')]
    
    if not files:
        print("No new files to upload.")
        return

    for file_name in files:
        local_path = os.path.join(LOCAL_DIR, file_name)
        remote_path = f"/inbound/{file_name}"
        
        try:
            print(f"Uploading {file_name}...")
            sftp.put(local_path, remote_path)
            
            # 3. Archive locally after successful upload
            shutil.move(local_path, os.path.join(ARCHIVE_DIR, file_name))
            print(f"Successfully archived {file_name}")
            
        except Exception as e:
            print(f"Failed to upload {file_name}: {e}")

    sftp.close()
    transport.close()

if __name__ == "__main__":
    upload_files()
