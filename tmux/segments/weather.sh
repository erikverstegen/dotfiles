#!/usr/bin/env bash

# Credit: https://github.com/passcod/tmux-powerline/blob/master/segments/weather_yahoo.sh
# Credit: https://github.com/erikw/tmux-powerline/blob/master/segments/weather.sh

# Test if the Yahoo! Weather service is online.
if ! $(ping -qc 1 -t 1 weather.yahoo.com &>/dev/null); then
    exit 0
fi

# Display a symbol for the different weather conditions.
# Available conditions: https://developer.yahoo.com/weather/documentation.html
get_condition_symbol() {
    local condition=$(echo $1 | tr '[:upper:]' '[:lower:]')

    case $condition in
        # Sunny
        "32"|"36")
            hour=$(date +%H)

            # Display a moon after 10 PM and before 5 AM, otherwise display a
            # sun.
            if [ $hour -ge $sunrise -o $hour -le $sunset ]; then
                echo "☾"
            else
                echo "☼"
            fi
        ;;

        # Rainy
        "5"|"6"|"8"|"9"|"10"|"11"|"12"|"35"|"40"|"45"|"47")
            echo "☂"
        ;;

        # Snowy
        "7"|"13"|"14"|"15"|"16"|"17"|"18"|"35"|"41"|"42"|"43"|"46")
            echo "❅"
        ;;

        # Cloudy
        "26"|"27"|"28"|"29"|"30"|"44")
            echo "☁"
        ;;

        # Stormy
        "0"|"1"|"2"|"3"|"4"|"37"|"38"|"39")
            echo "☈"
        ;;

        # Foggy
        "19"|"20"|"21"|"22"|"23")
            echo "〰"
        ;;

        # Windy
        "24")
            echo "⚑"
        ;;

        # Clear, fair, cold
        "25"|"31"|"33"|"34")
            echo "〇"
        ;;

        # Unknown condition.
        "3200"|*)
            echo "？"
        ;;
    esac
}

read_tmp_file() {
    cat /var/tmp/yahoo_weather.txt

    exit 0
}

# Test if the cache file exists.
if [ -f "/var/tmp/yahoo_weather.txt" ]; then
    # Get the last updated timestamp of the cache file.
    last_update=$(stat -f "%m" /var/tmp/yahoo_weather.txt)

    # Get the current timestamp.
    time_now=$(date +%s)

    # Test if the cache hasn't changed in 10 minutes.
    if [ $(echo "($time_now - $last_update) < 600" | bc) -eq 1 ]; then
        read_tmp_file
    fi
fi

# Get the weather forecast.
weather_data=$(curl --max-time 4 -s "https://query.yahooapis.com/v1/public/yql?q=select+%2A+from+weather.forecast+where+u%3D'c'+and+woeid%3D731699&format=xml")

if [ "$?" -eq "0" ]; then
    error=$(echo $weather_data | grep "problem_cause\|DOCTYPE")

    if [ -n "$error" ]; then
        if [ -f /var/tmp/yahoo_weather.txt ]; then
            read_tmp_file
        else
            exit 1
        fi
    fi

    # Get the current weather conditions.
    # <yweather:condition xmlns:yweather="http://xml.weather.yahoo.com/ns/rss/1.0" code="26" date="Tue, 13 Dec 2016 06:00 PM CET" temp="7" text="Cloudy"/>
    condition=$(echo "$weather_data" | grep -Zo "<yweather:condition [^<>]*/>")
    temperature=$(echo "$condition" | sed 's/.*temp="\([^"]*\)".*/\1/')
    condition=$(echo "$condition" | sed 's/.*code="\([^"]*\)".*/\1/')

    # Get the sunrise and sunset times.
    # <yweather:astronomy xmlns:yweather="http://xml.weather.yahoo.com/ns/rss/1.0" sunrise="8:36 am" sunset="4:29 pm"/>
    sunrise=$(date -jf "%H:%M %p" "$(echo "$weather_data" | grep "yweather:astronomy" | sed 's/^\(.*\)sunset.*/\1/' | sed 's/^.*sunrise="\(.*m\)".*/\1/')" +%H%M)
    sunset=$(date -jf "%H:%M %p" "$(echo "$weather_data" | grep "yweather:astronomy" | sed 's/^.*sunset="\(.*m\)".*/\1/')" +%H%M)

    # Display the weather information.
    echo "$(get_condition_symbol $condition) ${temperature}°C" | tee /var/tmp/yahoo_weather.txt
elif [ -f /var/tmp/yahoo_weather.txt ]; then
    read_tmp_file
else
    exit 1
fi
