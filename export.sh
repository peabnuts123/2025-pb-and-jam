#!/usr/bin/env bash

set -euo pipefail

# Config
BuildFolder="builds"
GodotExecutable="/Applications/Godot.app/Contents/MacOS/Godot"
OutputName="index.html"

# Clean up previous builds
rm -rf "${BuildFolder}"

# Create build folder
mkdir -p "${BuildFolder}"

# Export the project using Godot
echo "Exporting project with Godot..."
"${GodotExecutable}" --headless --export-release "Web" "${BuildFolder}/${OutputName}" # Update the output file extension as needed
if [ $? -eq 0 ]; then
    echo "Export successfully to: ${BuildFolder}/${OutputName}"
else
    echo "Export failed!"
    exit 1
fi

# Create a zip file with a datetime-stamped filename
Timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
ZipFile="spark-joy_${Timestamp}.zip"

echo "Creating zip archive: ${ZipFile}..."
pushd "${BuildFolder}" || exit 1
zip -r "${ZipFile}" ./* # Zip the contents of the build folder
popd || exit 1

if [ $? -eq 0 ]; then
    echo "Zip archive created successfully: ${ZipFile}"
else
    echo "Failed to create zip archive!"
    exit 1
fi
