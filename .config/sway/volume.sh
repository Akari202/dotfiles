speakers=$(wpctl status | rg "Sinks" --after-context 4 -m 1 | rg "Family")
speakers=${speakers%%.*}
speakers=${speakers##* }

bt=$(wpctl status | rg "Sinks" --after-context 6 -m 1 | rg "Ewin")
bt=${bt%%.*}
bt=${bt##* }


if [[ $1 == "mute" ]]; then
    wpctl set-mute "$speakers" toggle
    if [[ $bt != "" ]]; then
        wpctl set-mute "$bt" toggle
    fi
    exit
fi

if [[ $1 == "up" ]]; then
    wpctl set-volume "$speakers" 5%+
    if [[ $bt != "" ]]; then
        wpctl set-volume "$bt" 5%+
    fi
    exit
fi

if [[ $1 == "down" ]]; then
    wpctl set-volume "$speakers" 5%-
    if [[ $bt != "" ]]; then
        wpctl set-volume "$bt" 5%-
    fi
    exit
fi

echo "Error no action selected"
echo "Aux number: ${speakers}"
echo "Blutooth number: ${bt}"
