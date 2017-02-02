#!/usr/bin/env bash

CACHE_PERIOD=600
CACHE_FILE="/var/tmp/weather"

# Display a symbol for the different weather conditions.
# Available conditions: https://www.wunderground.com/weather/api/d/docs?d=resources/icon-sets
get_condition_symbol() {
    case $1 in
        # Thunderstorm
        "chancetstorms"|"tstorms")
            echo "☈"
        ;;

        # Rain
        "chancerain"|"chancesleet"|"rain"|"sleet")
            echo "☂"
        ;;

        # Snow
        "chanceflurries"|"chancesnow"|"flurries"|"snow")
            echo "❅"
        ;;

        # Atmosphere
        "fog"|"hazy")
            echo "〰"
        ;;

        # Sunny
        "sunny")
            echo "☼"
        ;;

        # Clear
        "clear")
            hour=$(date +%H%M)

            # Display a moon after sunset and before sunrise, otherwise display
            # a sun.
            if [ $hour -le $sunrise -o $hour -ge $sunset ]; then
                echo "☾"
            else
                echo "☼"
            fi
        ;;

        # Clouds
        "cloudy"|"mostlycloudy"|"mostlysunny"|"partlycloudy"|"partlysunny")
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
weather_data=$(curl --max-time 4 -s "http://api.wunderground.com/api/${WEATHER_APP_ID}/conditions/astronomy/q/${WEATHER_COUNTRY}/${WEATHER_CITY}.json")

if [ "$?" -eq 0 ]; then
    # Get the temperature.
    # "temp_c":9.8
    temperature=$(echo $weather_data | sed 's/.*"temp_c":\([^"]*\),.*/\1/')

    # Get the current weather condition.
    # "icon":"mostlycloudy"
    condition=$(echo $weather_data | sed 's/.*"icon":"\([^"]*\)".*/\1/')

    # Get the sunrise time.
    # "sunrise": { "hour":"8", "minute":"29" }
    sunrise_hour=$(echo $weather_data | sed 's/.*"sunrise": {\([^}]*\)}.*/\1/' | sed 's/.*"hour":"\([^"]*\)".*/\1/')
    sunrise_minute=$(echo $weather_data | sed 's/.*"sunrise": {\([^}]*\)}.*/\1/' | sed 's/.*"minute":"\([^"]*\)".*/\1/')
    sunrise=$(date -jf "%H:%M" "${sunrise_hour}:${sunrise_minute}" +%H%M)

    # Get the sunset time.
    # "sunset": { "hour":"17", "minute":"29" }
    sunset_hour=$(echo $weather_data | sed 's/.*"sunset": {\([^}]*\)}.*/\1/' | sed 's/.*"hour":"\([^"]*\)".*/\1/')
    sunset_minute=$(echo $weather_data | sed 's/.*"sunset": {\([^}]*\)}.*/\1/' | sed 's/.*"minute":"\([^"]*\)".*/\1/')
    sunset=$(date -jf "%H:%M" "${sunset_hour}:${sunset_minute}" +%H%M)

    echo "$(get_condition_symbol $condition) $(printf "%.0f" $temperature)°C" | tee $CACHE_FILE
elif [ -f $CACHE_FILE ]; then
    cat $CACHE_FILE

    exit 0
else
    exit 1
fi
