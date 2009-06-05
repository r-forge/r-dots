
# Run an R process to wait for a mutex, do some
# job that requires atomic transactions, release the
# mutex, and so on.

# Server that controls the mutex
host <- "127.0.0.1"

mutex <- SocketSemaphore(host, port=7777)
for (kk in 1:50) {
  if (acquire(mutex)) {
    cat("Client acquired mutex.\n")
    Sys.sleep(runif(n=1, max=0.01))
    release(mutex)
    cat("Client released mutex.\n")
    Sys.sleep(runif(n=1, max=0.2))
  }
}
