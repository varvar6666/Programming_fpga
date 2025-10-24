# GTKWave Configuration Guide

## VCD Generation Added to All Testbenches

Все testbench файлы теперь генерируют VCD файлы для просмотра временных диаграмм в GTKWave:

### Основные модули:
- `counter_0_999_tb.v` → `out/counter_0_999_tb.vcd`
- `shift_register_counter_tb.v` → `out/shift_register_counter_tb.vcd`
- `pattern_detector_1101_tb.v` → `out/pattern_detector_1101_tb.vcd`
- `signal_analysis_tb.v` → `out/signal_analysis_tb.vcd`
- `advanced_timer_simple_tb.v` → `out/advanced_timer_simple_tb.vcd`
- `advanced_timer_v2_tb.v` → `out/advanced_timer_v2_tb.vcd`

### Отладочные модули:
- `debug_timer_tb.v` → `out/debug_timer_tb.vcd`
- `simple_debug_tb.v` → `out/simple_debug_tb.vcd`
- `simple_timer_test_tb.v` → `out/simple_timer_test_tb.vcd`
- `debug_delay_tb.v` → `out/debug_delay_tb.vcd`

## Способы запуска GTKWave

### 1. Через Makefile (рекомендуется)
```bash
# Запустить GTKWave с конкретным файлом
make gtkwave TB=counter_0_999_tb

# Запустить GTKWave со всеми VCD файлами
make gtkwave-all

# Показать справку
make help
```

### 2. Через bash-скрипт
```bash
# Запустить GTKWave с конкретным файлом
./gtkwave.sh counter_0_999_tb

# Показать справку и доступные файлы
./gtkwave.sh
```

### 3. Через VSCode Tasks
- Нажмите `Ctrl+Shift+P`
- Выберите "Tasks: Run Task"
- Выберите "Run GTK-wave"
- Введите имя testbench (например: `counter_0_999_tb`)

### 4. Прямая команда
```bash
# С конкретным файлом
gtkwave out/counter_0_999_tb.vcd

# Со всеми файлами
gtkwave out/*.vcd
```

## Полный рабочий процесс

1. **Запустить тест:**
   ```bash
   make counter_0_999_tb
   ```

2. **Открыть GTKWave:**
   ```bash
   make gtkwave TB=counter_0_999_tb
   ```

3. **Просмотреть временные диаграммы** в GTKWave

## Что было исправлено

- Исправлена конфигурация VSCode для Linux (убрано `.exe`, исправлены пути)
- Добавлена VCD генерация во все testbench файлы
- Созданы удобные команды в Makefile
- Создан bash-скрипт для быстрого запуска
- Настроена интеграция с VSCode toolbar

Теперь вы можете легко просматривать временные диаграммы для всех ваших модулей.