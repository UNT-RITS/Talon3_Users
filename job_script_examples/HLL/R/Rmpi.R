library(Rmpi)

serial_time1 <- Sys.time() 
mat1 = matrix (c(1:9000000),3000,3000)
mat2 = matrix (c(1:9000000),3000,3000)
mat3 = mat1 %*% mat2
serial_time2 <- Sys.time()

parallel_time1 <- Sys.time()
MatMul_worker <- function() {
       worker_rank <- mpi.comm.rank() - 1
        if(worker_rank == ( num_worker )){
                worker_result <- mat1[ (nrow_worker * worker_rank + 1): (nrow_worker * worker_rank + lastRow_worker),] %*% mat2
        } else {
                worker_result <- mat1[ (nrow_worker * worker_rank + 1): (nrow_worker * worker_rank + nrow_worker),] %*% mat2
	}
        mpi.gather.Robj(worker_result, root = 0, comm = 1)
}


num_worker <- mpi.universe.size() - 1
mpi.spawn.Rslaves(nslaves=num_worker)
mat1 = matrix (c(1:9000000),3000,3000)
mat2 = matrix (c(1:9000000),3000,3000)
mat3 = NULL

dim1 <- dim(mat1)
dim2 <- dim(mat2)


mpi.remote.exec(paste("Hello, I am ", mpi.comm.rank(), " of ", mpi.comm.size(), " and I am on ", mpi.get.processor.name()))

# Broadcasting to workers
mpi.bcast.Robj2slave(mat1)
mpi.bcast.Robj2slave(mat2)
mpi.bcast.Robj2slave(num_worker)
# Sending row information to workers
nrow_worker <- ceiling(dim1[1]/(num_worker))
lastRow_worker <- dim1[1] - num_worker * nrow_worker
mpi.bcast.Robj2slave(nrow_worker)
mpi.bcast.Robj2slave(lastRow_worker)


mpi.bcast.Robj2slave(MatMul_worker)

mpi.bcast.cmd(MatMul_worker())

worker_result <- NULL
final_result <- mpi.gather.Robj(worker_result)

for(i in 1:num_worker){
	mat3 <- rbind(mat3, final_result[[i + 1]])
}

mpi.close.Rslaves()
parallel_time2 <- Sys.time() 

print(paste("Serial time: ", serial_time2 - serial_time1))
print(paste("Parallel time: ",parallel_time2 - parallel_time1))

mpi.quit()





