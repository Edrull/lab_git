#!/bin/bash

filename="sysinfo.html"

echo "<html>" > $filename
echo "	<head>" >> $filename
echo '		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">' >> $filename
echo '		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">' >> $filename
echo "	</head>" >> $filename
echo "	<body>" >> $filename
echo "		<h1>Информация об этом компьютере</h1>" >> $filename
echo "		<table class='table' style='width-min:400px'>" >> $filename
echo "			<tbody>" >> $filename


# Код создания разметки в виде таблицы характеристик этого компьютера

cpu=$(cat /proc/cpuinfo | grep "model name" | sed 1d | awk -F ":" {'print $2'})

echo "					<tr><td>Процессор:</td><td>$cpu</td></tr>" >> $filename

l1_cache=$(cat sys_info | grep "memory" | sed 1d | sed 2d | awk {'print $3'})

echo "					<tr><td>Кэш 1 уровня:</td><td>$l1_cache</td></tr>" >> $filename

l2_cache=$(cat sys_info | grep "memory" | sed 1,2d | awk {'print $3'})

echo "					<tr><td>Кэш 2 уровня:</td><td>$l2_cache</td></tr>" >> $filename

ram=$(cat sys_info | grep "memory" | sed 2,3d | awk {'print $3'})

echo "					<tr><td>RAM:</td><td>$ram</td></tr>" >> $filename

video=$(cat sys_info | grep "display" | awk {'print $3'})

echo "					<tr><td>Видеокарта:</td><td>$video</td></tr>" >> $filename

kernel=$(uname -a | awk {'print $3'})

echo "					<tr><td>Версия ядра:</td><td>$kernel</td></tr>" >> $filename

echo "			</tbody>" >> $filename
echo "		</table>" >> $filename
echo "	</body>" >> $filename
echo "</html>" >> $filename
