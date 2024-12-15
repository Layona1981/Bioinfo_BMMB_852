
# Variables
PYTHON=python3
PIP=pip
REQUIREMENTS=requirements.txt
SCRIPT=differential_expression_analysis.py

# Targets
.PHONY: all install run clean

# Default target
all: install run

# Install required libraries
install:
	$(PIP) install -r $(REQUIREMENTS)

# Run the analysis script
run:
	$(PYTHON) $(SCRIPT)

# Clean up (optional, modify as needed)
clean:
	rm -rf __pycache__


