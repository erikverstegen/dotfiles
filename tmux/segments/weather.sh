#!/usr/bin/env bash

# Cache expiry time in seconds.
CACHE_PERIOD=600
CACHE_FILE="/var/tmp/weather"
CITY="$1"
UNIT="$2"

# Test if the OpenWeatherMap API is available.
if ! $(ping -qc 1 -t 1 api.openweathermap.org &>/dev/null); then
    exit 1
fi

# Display a symbol for the different weather conditions.
# Available conditions: http://openweathermap.org/weather-conditions
get_condition_symbol() {
    case $1 in
        # Thunderstorm
        "200"|"201"|"202"|"210"|"211"|"212"|"221"|"230"|"231"|"232")
            echo "☈"
        ;;

        # Drizzle and rain.
        "300"|"301"|"302"|"310"|"311"|"312"|"313"|"314"|"231"| \
        "500"|"501"|"502"|"503"|"504"|"511"|"520"|"521"|"522"|"531")
            echo "☂"
        ;;

        # Snow
        "600"|"601"|"602"|"611"|"612"|"615"|"616"|"620"|"621"|"622")
            echo "❅"
        ;;

        # Atmosphere
        "701"|"711"|"721"|"731"|"741"|"751"|"761"|"762"|"771"|"781")
            echo "〰"
        ;;

        # Clear
        "800")
            hour=$(date -u +%H)

            # Display a moon after sunset and before sunrise, otherwise display
            # a sun.
            if [ $hour -ge $sunrise -o $hour -le $sunset ]; then
                echo "☾"
            else
                echo "☼"
            fi
        ;;

        # Clouds
        "801"|"802"|"803"|"804")
            echo "☁"
        ;;

        # Unknown condition.
        *)
            echo "？"
        ;;
    esac
}

# Test if the cache file exists.
if [ -f $CACHE_FILE ]; then
    # Get the last updated timestamp of the cache file.
    last_updated=$(stat -f "%m" "$CACHE_FILE")

    # Get the current timestamp.
    time_now=$(date +%s)

    # Test if the cache file hasn't been invalidated.
    if [ $(echo "($time_now - $last_updated) < $CACHE_PERIOD" | bc) -eq 1 ]; then
        cat $CACHE_FILE

        exit 0
    fi
fi

# Get the weather data.
weather_data=$(curl --max-time 4 -s "http://api.openweathermap.org/data/2.5/weather?q=${CITY}&units=${UNIT}&mode=xml&appid=${WEATHER_APP_ID}")

if [ "$?" -eq 0 ]; then
    # Get the temperature.
    # <temperature value="8.44" min="7" max="10" unit="metric">
    temperature=$(echo "$weather_data" | grep -Zo "<temperature [^<>]*>" | sed 's/.*value="\([^"]*\)".*/\1/')

    # Get the weather condition.
    # <weather number="701" value="mist" icon="50n">
    condition=$(echo "$weather_data" | grep -Zo "<weather [^<>]*>" | sed 's/.*number="\([^"]*\)".*/\1/')

    # Get the sunrise and sunset times.
    # <sun rise="2016-12-14T07:36:24" set="2016-12-14T15:28:55">
    sunrise=$(date -jf "%Y-%m-%dT%H:%M:%S" "$(echo "$weather_data" | grep -Zo "<sun [^<>]*>" | sed 's/.*rise="\([^"]*\)".*/\1/')" +%H%M)
    sunset=$(date -jf "%Y-%m-%dT%H:%M:%S" "$(echo "$weather_data" | grep -Zo "<sun [^<>]*>" | sed 's/.*set="\([^"]*\)".*/\1/')" +%H%M)

    echo "$(get_condition_symbol $condition) ${temperature}°C" | tee -a $CACHE_FILE
elif [ -f $CACHE_FILE ]; then
    cat $CACHE_FILE

    exit 0
else
    exit 1
fi
