#!/bin/bash
# Простой установщик для ntpdated

if [ "$EUID" -ne 0 ]; then 
  echo "Пожалуйста, запустите установщик от имени root"
  exit
fi

echo "Установка ntpdated..."

# Копируем файлы
cp ntpdated.sh /usr/local/sbin/ntpdated
chmod +x /usr/local/sbin/ntpdated

cp ntpdated.init /etc/init.d/ntpdated
chmod +x /etc/init.d/ntpdated

# Регистрируем в sysvinit
update-rc.d ntpdated defaults

# Запускаем
/etc/init.d/ntpdated start

echo "Установка завершена. Демон запущен в фоне."
