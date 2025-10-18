# Makefile для лабораторной работы 3

# Компилятор
IVERILOG = iverilog
VVP = vvp

# Флаги компиляции
CFLAGS = -g2012

# Цели для FSM частей
FSM_TARGETS = counter_0_999_tb shift_register_counter_tb pattern_detector_1101_tb advanced_timer_v2_tb

# Цели для анализа сигналов
SIGNAL_TARGETS = signal_analysis_tb

# Все цели
ALL_TARGETS = $(FSM_TARGETS) $(SIGNAL_TARGETS)

.PHONY: all fsm signals clean help

# По умолчанию компилируем все
all: $(ALL_TARGETS)

# Компиляция FSM частей
fsm: $(FSM_TARGETS)

# Компиляция анализа сигналов
signals: $(SIGNAL_TARGETS)

# Счетчик 0-999
counter_0_999_tb: counter_0_999.v counter_0_999_tb.v
	$(IVERILOG) $(CFLAGS) -o $@ counter_0_999.v counter_0_999_tb.v
	$(VVP) $@

# Сдвиговый регистр с счетчиком
shift_register_counter_tb: shift_register_counter.v shift_register_counter_tb.v
	$(IVERILOG) $(CFLAGS) -o $@ shift_register_counter.v shift_register_counter_tb.v
	$(VVP) $@

# Детектор паттерна 1101
pattern_detector_1101_tb: pattern_detector_1101.v pattern_detector_1101_tb.v
	$(IVERILOG) $(CFLAGS) -o $@ pattern_detector_1101.v pattern_detector_1101_tb.v
	$(VVP) $@

# Продвинутый таймер
advanced_timer_v2_tb: advanced_timer_v2.v advanced_timer_v2_tb.v
	$(IVERILOG) $(CFLAGS) -o $@ advanced_timer_v2.v advanced_timer_v2_tb.v
	$(VVP) $@

# Упрощенный таймер
advanced_timer_simple_tb: advanced_timer_simple.v advanced_timer_simple_tb.v
	$(IVERILOG) $(CFLAGS) -o $@ advanced_timer_simple.v advanced_timer_simple_tb.v
	$(VVP) $@

# Анализ сигналов
signal_analysis_tb: part1_combinational.v part2_combinational.v part3_combinational.v part4_sequential.v part5_sequential.v part6_sequential.v signal_analysis_tb.v
	$(IVERILOG) $(CFLAGS) -o $@ part1_combinational.v part2_combinational.v part3_combinational.v part4_sequential.v part5_sequential.v part6_sequential.v signal_analysis_tb.v
	$(VVP) $@

# Очистка
clean:
	rm -f $(ALL_TARGETS) *.vcd

# Помощь
help:
	@echo "Доступные команды:"
	@echo "  make all      - Компилировать и запустить все тесты"
	@echo "  make fsm      - Компилировать и запустить FSM тесты"
	@echo "  make signals  - Компилировать и запустить тесты анализа сигналов"
	@echo "  make clean    - Удалить скомпилированные файлы"
	@echo "  make help     - Показать эту справку"
	@echo ""
	@echo "Отдельные тесты:"
	@echo "  make counter_0_999_tb"
	@echo "  make shift_register_counter_tb"
	@echo "  make pattern_detector_1101_tb"
	@echo "  make advanced_timer_v2_tb"
	@echo "  make signal_analysis_tb"
