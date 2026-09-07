# Scripting for Hardware & Verification Automation

This directory contains Python and Perl scripts commonly tested during EDA scripting rounds.

---

## Directory Structure

```
scripting/
├── linux_commands/     # Linux shell commands & bash script interview questions
├── perl/               # Perl fundamentals
├── python/             # Python EDA log parsing, CSV processing, and text analysis
└── practice_files/     # Sample logs, student CSVs, and notes used by the test scripts
```

---

## 3. Python Automation & EDA Log Parsing ([python/](python/))

Practical scripts simulating everyday verification engineering tasks (regression log parsing, data sanitization, sorting):

| File | Input Data | Task & Script Functionality |
| :--- | :--- | :--- |
| [python/count_info_logs.py](python/count_info_logs.py) | `log_file.txt` | Counts the total occurrences of `[INFO]` level log messages in a simulation log. |
| [python/extract_error_info.py](python/extract_error_info.py) | `log_file.txt` | Scans simulator logs to extract line numbers, error codes, and timestamps for all `[ERROR]` and `[FATAL]` messages, writing formatted output to `exercise_error_info.txt`. |
| [python/sort_logs.py](python/sort_logs.py) | `log_file.txt` | Parses timestamped log entries and reorders them chronologically into `sorted_logs.txt`. |
| [python/inventory_data_cleaning.py](python/inventory_data_cleaning.py) | `inventory.csv` | **Data Sanitization**: Cleans inconsistent CSV records by handling missing values, standardizing column types, stripping whitespace, and saving clean records to `cleaned_inventory.csv`. |
| [python/sort_inventory.py](python/sort_inventory.py) | `inventory.csv` | Parses product inventory CSV and sorts items based on quantity and price, saving to `sorted_inventory.csv`. |
| [python/read_student_data.py](python/read_student_data.py) | `students.csv` | Uses Python's `csv` library (`csv.reader` and `csv.DictReader`) to safely parse tabular data without manual split errors. |
| [python/write_student_data.py](python/write_student_data.py) | `students.csv` | Writing to CSVs using `csv.writer`, demonstrating append mode (`'a'`) vs. overwrite mode (`'w'`). |
| [python/sort_students.py](python/sort_students.py) | `students.csv` | Multi-key sorting of student records by GPA and last name using lambda keys (`key=lambda x: (-float(x['gpa']), x['name'])`). |
| [python/student_score_stats.py](python/student_score_stats.py) | `students.csv` | Computes statistical metrics (mean, median, standard deviation, min, max) on numerical dataset columns. |
| [python/word_frequency_counter.py](python/word_frequency_counter.py) | `notes.txt` | Reads plain text notes, normalizes case, removes punctuation, and outputs word frequency histograms using `collections.Counter` and dictionaries. |

---

## 3. Practice Data Files ([practice_files/](practice_files/))

Test datasets provided to benchmark and run the scripts:
- `log_file.txt`: Sample multi-level simulator log containing `[INFO]`, `[WARNING]`, `[ERROR]`, and `[DEBUG]` entries.
- `inventory.csv`: Sample hardware component inventory with part IDs, quantities, unit prices, and corrupted rows.
- `students.csv`: Sample tabular student records with names, IDs, departments, and GPAs.
- `notes.txt`: Multi-paragraph text sample for text processing exercises.