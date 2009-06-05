
# Run a seperate R process providing a mutex server
srv <- SocketMutexServer(port=7777);
run(srv, verbose=-10);
