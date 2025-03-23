#!/bin/bash


# Run minikube service command in the background and capture its output
echo "Exposing minikube UI service..."
minikube service core-synapse-ui --url > url_file.txt &
SERVICE_PID=$!

# Give it a moment to start up and write the URL
sleep 3

# Check if the URL file exists and has content
if [ -s url_file.txt ]; then
    URL=$(cat url_file.txt)
    echo "Opening $URL in browser..."
    
    # Open the URL in the default browser
    case "$(uname -s)" in
        Darwin*)    open "$URL" ;;
        Linux*)     xdg-open "$URL" 2>/dev/null || sensible-browser "$URL" 2>/dev/null || gnome-open "$URL" 2>/dev/null || kde-open "$URL" 2>/dev/null || firefox "$URL" 2>/dev/null || google-chrome "$URL" 2>/dev/null ;;
        CYGWIN*|MINGW*|MSYS*)  start "$URL" ;;
        *)          echo "Unsupported operating system. Please open the URL manually: $URL" ;;
    esac
    
    echo "Service is running. Press Ctrl+C to stop."
    
    # Wait for the user to press Ctrl+C, then clean up
    wait $SERVICE_PID
else
    echo "Failed to get URL for core-synapse-ui service"
    kill $SERVICE_PID 2>/dev/null
    exit 1
fi

# Clean up the temporary file
rm -f url_file.txt
exit 0
