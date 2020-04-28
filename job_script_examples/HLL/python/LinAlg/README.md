# Example of using SciPy on Talon

This is a simple example of running a Python calucation on Talon3

This job uses NumPy/SciPy to run some Linear Algbra routines

This is a serial (1 core) job

## Files
- Job Script: LinAlgTest.job
- Python Input file: LinAlgTest.py
- Sample Output file: LinAlgTest.sample.out


## To run on Talon3

```
sbatch LinAlgTest.job
```
This will run the Python job and output to a file, LinAlgTest.out.
You can compare this is the sample output file LinAlgTest.sample.out.

