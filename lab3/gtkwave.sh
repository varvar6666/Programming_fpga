#!/bin/bash

# Скрипт для запуска GTKWave с файлом testbench
# Использование: ./gtkwave.sh имяфайла_tb

if [ $# -eq 0 ]; then
    echo "Использование: $0 имяфайла_tb"
    echo "Пример: $0 counter_0_999_tb"
    echo ""
    echo "Доступные VCD файлы:"
    ls -1 out/*.vcd 2>/dev/null | sed 's/out\///g' | sed 's/\.vcd$//g' || echo "Нет VCD файлов в папке out/"
    exit 1
fi

FILENAME="$1"
VCD_FILE="out/${FILENAME}.vcd"

if [ ! -f "$VCD_FILE" ]; then
    echo "Ошибка: Файл $VCD_FILE не найден!"
    echo ""
    echo "Доступные VCD файлы:"
    ls -1 out/*.vcd 2>/dev/null | sed 's/out\///g' | sed 's/\.vcd$//g' || echo "Нет VCD файлов в папке out/"
    exit 1
fi

echo "Запуск GTKWave с файлом: $VCD_FILE"
gtkwave "$VCD_FILE" &



