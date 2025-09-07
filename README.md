# NBack Task Simulation

Author:Mariam

## Overview
This repository contains a simulated N-back working memory task implemented in MATLAB and Python. The project demonstrates how working memory performance can be assessed using 2-back and 3-back tasks with a simple GUI.

> ⚠️ Note: All data and performance plots included in this repository are simulated for demonstration purposes. No real participants were involved.

## What the Code Does

### MATLAB Version (`NBack_GUI_Colored.m`)
- Generates 2-back and 3-back tasks with random letter sequences.
- Displays a GUI for participants to respond (Z = target, M = non-target).
- Records responses and reaction times.
- Computes accuracy and mean reaction time.
- Saves a CSV file (`Extended_NBack_GUI_Colored_Results.csv`) with all trial data.
- Generates colored bar charts for accuracy and reaction times (`Performance_Summary_Colored.png`).

### Python/Jupyter Version (`NBack_Simulation.ipynb`)
- Simulates the same N-back task computationally.
- Generates CSV data and performance plots without requiring MATLAB.
- Useful for demonstration and for GitHub visualization when MATLAB is unavailable.

## Files Included

- `NBack_GUI_Colored.m` → Main MATLAB script with GUI.
- `NBack_Simulation.ipynb` → Jupyter Notebook simulating N-back task.
- `Extended_NBack_GUI_Colored_Results.csv` → Simulated trial data.
- `Performance_Summary_Colored.png` → Colored performance summary plots.
- `README.md` → Project description and instructions.

## How to Use

1. MATLAB 
   - Open `NBack_GUI_Colored.m` in MATLAB or MATLAB Online.  
   - Run the script to simulate a session.  
   - CSV and PNG files will be automatically generated in the same folder.

2. Python/Jupyter  
   - Open `NBack_Simulation.ipynb` in Jupyter Notebook or Google Colab.  
   - Run all cells to simulate the task and generate CSV/PNG files.

> Both versions generate simulated data, ideal for demonstrating the project without real participants.

## Future Extensions
- The MATLAB code can be adapted later to record real participant data, replacing the simulated responses with actual input from participants.  
- The Python simulation can also be extended to generate different task variations or larger datasets for testing analysis pipelines.

