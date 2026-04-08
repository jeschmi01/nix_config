get_icon() {
  local mac=$1
  local type=$(bluetoothctl info "$mac" | grep "Icon:" | cut -d ' ' -f 2)
  case "$type" in
    audio-card|audio-headphones|audio-headset) echo "󰋋" ;;
    input-mouse) echo "󰍽" ;;
    input-keyboard) echo "󰌌" ;;
    phone) echo "󰏲" ;;
    video-display) echo "󰍹" ;;
    *) echo "󰂯" ;;
  esac
}
