# vim:ft=sh

# Statusbar loop
while true; do
	xsetroot -name "$( date +"%H:%M" )"
done &

# Autostart section
xfce4-session & # polkit backend
picom -bGF & # compositor
nitrogen --restore & # wallpaper
xmodmap -e "pointer = 1 2 3"
if [[ ! -f /sys/class/intel_scu_ipc/ ]]; then
	exec /usr/bin/i3
else
	exec /usr/bin/sway
fi

pipeline() {
	s="$(nvidia-settings -q CurrentMetaMode -t)"

	if [[ "${s}" != "" ]]; then
		s="${s#*" :: "}"
		nvidia-settings -a CurrentMetaMode="${s//\}/, ForceCompositionPipeline=On\}}"
	fi
}

detect_gpu=$(dmesg | grep nvidia)
if [ ! $detect_gpu ]; then
	echo "All good"
else
	pipeline
fi
