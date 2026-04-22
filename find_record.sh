#This script will look for files where the Entity (E) record matches your hospital and the Detail (D) record matches your account number, all within the context of your specific date.

#!/bin/bash

# Configuration - adjust these paths to your environment
SEARCH_DIR="./pending_claims"
ARCHIVE_DIR="./processed_claims"

# Check for all 4 arguments
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <Hospital_Name> <Year> <Month> <Account_Number>"
    echo "Example: $0 CEDAR 2023 10 123456789"
    exit 1
fi

HOSPITAL=$1
YEAR=$2
MONTH=$3
ACCT=$4
DATE_QUERY="^E.*$YEAR$MONTH"

echo "Searching for Hospital: $HOSPITAL | Date: $MONTH/$YEAR | Acct: $ACCT"
echo "------------------------------------------------------------------"

# Search both Pending and Archive folders
for DIR in "$SEARCH_DIR" "$ARCHIVE_DIR"; do
    # Find files containing the Hospital Name and Date in the 'E' record
    # then check if that same file contains the Account Number in a 'D' record
    files=$(grep -l "$DATE_QUERY" $DIR/*.{txt,edi} 2>/dev/null | xargs grep -l "D|.*$ACCT")

    for file in $files; do
        echo "[FOUND]: $file"
        # Optional: Print the specific E and D lines for verification
        grep -E "^E.*$HOSPITAL|^D.*$ACCT" "$file"
        echo "------------------------------------------------------------------"
    done
done
