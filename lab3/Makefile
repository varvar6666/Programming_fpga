# Makefile для лабораторной работы 3

# Компилятор
IVERILOG = iverilog
VVP = vvp

# Флаги компиляции
CFLAGS = -g2012

# Цели для анализа сигналов (правильные файлы)
SIGNAL_TARGETS = part_1_tb part_2_tb part_3_tb part_4_tb part_5_tb part_6_tb

# Цели для FSM частей (правильные файлы)
FSM_TARGETS = FSM_part_1_tb FSM_part_2_tb FSM_part_3_tb FSM_part_4_tb

# Все цели
ALL_TARGETS = $(SIGNAL_TARGETS) $(FSM_TARGETS)

.PHONY: all signals fsm clean help gtkwave gtkwave-all

# По умолчанию компилируем все
all: $(ALL_TARGETS)

# Компиляция анализа сигналов
signals: $(SIGNAL_TARGETS)

# Компиляция FSM частей
fsm: $(FSM_TARGETS)

# Part 1: Комбинационная схема q = (a | b) & (c | d)
part_1_tb: part_1.v part_1_tb.v
	$(IVERILOG) $(CFLAGS) -o part_1_tb part_1.v part_1_tb.v
	$(VVP) part_1_tb

# Part 2: Комбинационная схема q = b | c
part_2_tb: part_2.v part_2_tb.v
	$(IVERILOG) $(CFLAGS) -o part_2_tb part_2.v part_2_tb.v
	$(VVP) part_2_tb

# Part 3: Комбинационная схема с мультиплексором
part_3_tb: part_3.v part_3_tb.v
	$(IVERILOG) $(CFLAGS) -o part_3_tb part_3.v part_3_tb.v
	$(VVP) part_3_tb

# Part 4: Последовательная схема с тактовым сигналом
part_4_tb: part_4.v part_4_tb.v
	$(IVERILOG) $(CFLAGS) -o part_4_tb part_4.v part_4_tb.v
	$(VVP) part_4_tb

# Part 5: Счетчик с остановкой
part_5_tb: part_5.v part_5_tb.v
	$(IVERILOG) $(CFLAGS) -o part_5_tb part_5.v part_5_tb.v
	$(VVP) part_5_tb

# Part 6: XOR логика с состоянием
part_6_tb: part_6.v part_6_tb.v
	$(IVERILOG) $(CFLAGS) -o part_6_tb part_6.v part_6_tb.v
	$(VVP) part_6_tb

# FSM Part 1: Счетчик 0-999
FSM_part_1_tb: FSM_part_1.v FSM_part_1_tb.v
	$(IVERILOG) $(CFLAGS) -o FSM_part_1_tb FSM_part_1.v FSM_part_1_tb.v
	$(VVP) FSM_part_1_tb

# FSM Part 2: Сдвиговый регистр-счетчик
FSM_part_2_tb: FSM_part_2.v FSM_part_2_tb.v
	$(IVERILOG) $(CFLAGS) -o FSM_part_2_tb FSM_part_2.v FSM_part_2_tb.v
	$(VVP) FSM_part_2_tb

# FSM Part 3: Детектор паттерна 1101
FSM_part_3_tb: FSM_part_3.v FSM_part_3_tb.v
	$(IVERILOG) $(CFLAGS) -o FSM_part_3_tb FSM_part_3.v FSM_part_3_tb.v
	$(VVP) FSM_part_3_tb

# FSM Part 4: Продвинутый таймер
FSM_part_4_tb: FSM_part_4.v FSM_part_4_tb.v
	$(IVERILOG) $(CFLAGS) -o FSM_part_4_tb FSM_part_4.v FSM_part_4_tb.v
	$(VVP) FSM_part_4_tb

# Очистка временных файлов
clean:
	rm -f *.out *.vcd *.aux *.log
	rm -f part_1_tb part_2_tb part_3_tb part_4_tb part_5_tb part_6_tb
	rm -f FSM_part_1_tb FSM_part_2_tb FSM_part_3_tb FSM_part_4_tb

# GTKWave команды
gtkwave:
	@if [ -z "$(TB)" ]; then \
		echo "Ошибка: Укажите имя testbench через TB=имяфайла_tb"; \
		echo "Пример: make gtkwave TB=part_1_tb"; \
		echo ""; \
		echo "Доступные VCD файлы:"; \
		ls -1 out/*.vcd 2>/dev/null | sed 's/out\///g' | sed 's/\.vcd$$//g' || echo "Нет VCD файлов в папке out/"; \
		exit 1; \
	fi
	@if [ ! -f "out/$(TB).vcd" ]; then \
		echo "Ошибка: Файл out/$(TB).vcd не найден!"; \
		echo "Сначала запустите тест: make $(TB)"; \
		exit 1; \
	fi
	@echo "Запуск GTKWave с файлом: out/$(TB).vcd"
	gtkwave "out/$(TB).vcd" &

gtkwave-all:
	@if [ ! -d "out" ] || [ -z "$$(ls out/*.vcd 2>/dev/null)" ]; then \
		echo "Ошибка: Нет VCD файлов в папке out/"; \
		echo "Сначала запустите тесты: make all"; \
		exit 1; \
	fi
	@echo "Запуск GTKWave со всеми VCD файлами"
	gtkwave out/*.vcd &

# Справка
help:
	@echo "Доступные команды:"
	@echo "  make all          - Компиляция всех модулей"
	@echo "  make signals      - Компиляция модулей анализа сигналов"
	@echo "  make fsm          - Компиляция FSM модулей"
	@echo "  make clean        - Очистка временных файлов"
	@echo "  make gtkwave TB=имя - Запуск GTKWave с указанным файлом"
	@echo "  make gtkwave-all  - Запуск GTKWave со всеми VCD файлами"
	@echo ""
	@echo "Доступные модули:"
	@echo "  part_1_tb до part_6_tb - Модули анализа сигналов"
	@echo "  FSM_part_1_tb до FSM_part_4_tb - FSM модули"