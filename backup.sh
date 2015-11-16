#!/bin/bash
# Скрипт автоматического копирования базы 1с
input_file=$1
backup_suffix="BASE_1C"

if [ -z $input_file ]
then
  echo "Попробуйте запустить скрипт так: $0 каталог для копирования"
exit 0
fi

tar -czpf $(date +%Y-%m-%d:%T)-$backup_suffix.tar.gz $input_file

# количество секунд в 11 месяцах
period=2592000

# цикл по всем копиям резервных копий
for i in $(ls *$backup_suffix.tar.gz)
do
  # дата из имени файла
  time=${i%-$backup_suffix.tar.gz}
  # переводим дату из имени файла в unixtime
  file_unixtime=$(date --date="$time" +%s)
  # текущий unixtime
  current_unixtime=$(date +%s)

  # если разница в unixtime и unixtime файла больше периода, то удаляем файл
  if [ $(($current_unixtime - $file_unixtime)) -gt $period ]
  then
    rm $i
    echo "файл $i был удален"
  fi
done
