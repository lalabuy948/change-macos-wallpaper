#!/usr/bin

WALLPAPERS_DIRECTORY="~/Pictures/wallpapers-unsplash/";
URL="https://api.unsplash.com/photos/random/?client_id=09987f8449b94d9e98b41bf14747596e5557b2f7878853399d969bf38a54a611";

# Check if folder for pictures exist
if [ ! -d "~/Pictures/wallpapers-unsplash/" ]; then
  mkdir ~/Pictures/wallpapers-unsplash/
fi

# Get random picture from Unsplash
function getPicture() {
  local data=curl -s "${URL}" | json_pp  | grep "\"full\"" | awk -F "\"" '{print $4}'
  local picture=curl -L "${data}"
  return picture
}

# Change wallpaper value
function setWallpaper() {
  sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '${WALLPAPERS_DIRECTORY}${getPicture}'";
  killall Dock;
}
