# R job script examples

Examples of runing R jobs on Talon

* Matrix example
* Rmpi example
	- This example using MPI with R

## Simple Matrix example

The `simple_MatMul.R` file has a simple matrix multiplication example.

The `simple_MatMul.job` shows the job script needed to run the job.

In order to run this R job, you will need to run,

```
sbatch simple_MatMul.job
```

## Rmpi example

In order to speed up your R jobs, you will need to parallelize your R code. 

In the `simple_MatMut.R` example, it only uses **ONE** CPU core can cannot be speed up even if you request more cores via SLURM.

You will need change your R code in order to run your R job over multiple CPU cores.

One example is using MPI with the Rmpi package. 

The `Rmpi.R` file shows an example of using the Rmpi package to run a matrix multiplication.

The `Rmpi.job` file is the job scripte needed to run this job.

```
sbatch Rmpi.job
```


