#!/bin/bash

# Set the directory path to monitor
directory="stacks-2566-rplinux04.sv.splunk.com-2023-06-22T15h35m29s589766056ns-0400"

# Set the maximum number of files to keep
max_files=20

# Function to delete the oldest files if the count exceeds the maximum
delete_oldest_files() {
  file_count=$(ls -1 "$directory" | wc -l)
  files_to_delete=$((file_count - max_files))
  
  if (( files_to_delete > 0 )); then
    echo "Deleting $files_to_delete oldest file(s)..."
    ls -1t "$directory" | tail -n "$files_to_delete" | xargs -I {} rm "$directory/{}"
  fi
}

# Loop to monitor the directory
while true; do
  # Delete oldest files if the count exceeds the maximum
  delete_oldest_files
  
  # Sleep for a specified interval (e.g., 1 minute) before checking the directory again
  sleep 60
done
