#!/bin/bash

################################################################################
# 04/10/2022 - 1.1 - Разделил скрипт на консольные и GUI приложения
# 04/10/2022 - 1 - Решил всё же выложить скрипт
################################################################################
# Как можно отблагодарить:
# Оформить удобную для вас подписку на Boosty.to - https://boosty.to/lliammah/ref
# Разово поддержать через DonationAlerts - https://www.donationalerts.com/r/lliammah
################################################################################

VER="1.1"
DATE="04/10/2022"

Green=$'\e[1;32m'
Yellow=$'\e[1;33m'
End=$'\e[0m'

HEIGHT=0
WIDTH=60
CHOICE_HEIGHT=0
BACKTITLE="Установщик программ - версия ${VER} от ${DATE}"
TITLE="Выбор программного обеспечения"

: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}

notice() {
  echo " $Yellow♦$Green $1 ...$End"
}


DIALOG=(dialog --clear \
                 --backtitle "$BACKTITLE" \
				 --title "$TITLE" \
				 --separate-output --checklist "Выберите программы, которые хотите установить:" \
				 $HEIGHT $WIDTH $CHOICE_HEIGHT)

options=("keepassxc" "KeePassXC" off
 "appimagelauncher" "AppImageLauncher" off
 "obs-studio" "OBS Studio" off)

selections=$("${DIALOG[@]}" "${options[@]}" 2>&1 >/dev/tty)

# Обработаем статус выхода из диалога
return_value=$?

case $return_value in
  1)exit;;
  255)exit;;
esac

clear

# Добавление PPA репозиториев
for selection in $selections
do
 case $selection in
 "keepassxc")
  notice "Add PPA KeePassXC"
  sudo add-apt-repository ppa:phoerious/keepassxc -y
 ;;
 "appimagelauncher")
  notice "Add PPA AppImageLauncher"
  sudo add-apt-repository ppa:appimagelauncher-team/stable -y
 ;;
 "obs-studio")
  notice "Add PPA OBS Studio"
  sudo add-apt-repository ppa:obsproject/obs-studio -y
 ;;
 esac
done


# Обновим информацию по пакетам
notice "Get update package"
sudo apt update -y


# Установка выбранных программ
for selection in $selections
do
 case $selection in
 "keepassxc")
  notice "Installing KeePassXC"
  sudo apt install keepassxc -y
 ;;
 "appimagelauncher")
  notice "Installing AppImageLauncher"
  sudo apt install appimagelauncher -y
 ;;
 "obs-studio")
  notice "Installing OBS Studio"
  sudo apt install ffmpeg obs-studio -y
 ;;
 esac
done