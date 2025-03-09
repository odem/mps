#!/bin/bash
LOCALESTR=en_US.UTF-8
unset LANG
unset LANGUAGE
unset LC_LANG
unset LC_ALL
echo "$LOCALESTR UTF-8" | sudo tee /etc/locale.gen 2>/dev/null >/dev/null
sudo locale-gen "$LOCALESTR"
sudo update-locale
    LANG="$LOCALESTR" \
    LANGUAGE="$LOCALESTR" \
    LC_LANG="$LOCALESTR" \
    LC_ALL="$LOCALESTR" \
    LC_CTYPE="$LOCALESTR" \
    LC_NUMERIC="$LOCALESTR" \
    LC_TIME="$LOCALESTR" \
    LC_COLLATE="$LOCALESTR" \
    LC_MONETARY="$LOCALESTR" \
    LC_MESSAGES="$LOCALESTR" \
    LC_PAPER="$LOCALESTR" \
    LC_NAME="$LOCALESTR" \
    LC_ADDRESS="$LOCALESTR" \
    LC_TELEPHONE="$LOCALESTR" \
    LC_MEASUREMENT="$LOCALESTR" \
    LC_IDENTIFICATION="$LOCALESTR" \

echo "LANG=$LOCALESTR" | sudo tee /etc/default/locale
echo "LANGUAGE=$LOCALESTR" | sudo tee /etc/default/locale
echo "LC_ALL=$LOCALESTR" | sudo tee /etc/default/locale
# source ~/.bashrc
#
# # # Locales
# # export LANG=$LOCALESTR
# # export LANGUAGE=$LOCALESTR
# # sudo locale-gen "$LOCALESTR"
# echo "locales locales/default_environment_locale select $LOCALESTR" \
#     | sudo debconf-set-selections
# sudo dpkg-reconfigure -f noninteractive locales
