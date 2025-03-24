views=1
url="https://youtube.com/shorts/a13FwoLc6Kk"

while [ $views -le 10000 ]; do
    # Connect to VPN
    nmcli connection up "lo"
    sleep 5s  # Wait for VPN connection

    # Open the video in Chrome
    google-chrome "$url" &
    sleep 10s  # Allow the video to load

    # Refresh the page
    xdotool search --onlyvisible --class "chrome" windowactivate key ctrl+r
    sleep 10s  # Wait before closing

    # Close Chrome
    pkill chrome
    sleep 2s  # Ensure Chrome is closed

    # Disconnect VPN
    nmcli connection down "lo"
    sleep 5s  # Wait for VPN disconnection

    ((views++))
done

echo "All done"

