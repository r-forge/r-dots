
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# This example will try to connect to the Matlab server running on the
# same machine, e.g. Matlab$startServer(port=9998)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Create a Matlab client
matlab <- Matlab(host="localhost", port=9998)

# Connect to the Matlab server
if (!open(matlab))
  throw("Matlab server is not running: waited 30 seconds.")

# Run Matlab expressions on the Matlab server
res <- evaluate(matlab, "A=1+2;", "B=ones(2,20);")

# Get Matlab variables
data <- getVariable(matlab, c("A", "B"))
cat("Received variables:\n")
str(data)

# Set variables in Matlab
ABCD <- matrix(rnorm(10000), ncol=100)
str(ABCD)
setVariable(matlab, ABCD=ABCD)

# Retrieve what we just set
data <- getVariable(matlab, "ABCD")
cat("Received variables:\n")
str(data)

# Create a function (M-file) on the Matlab server
setFunction(matlab, "          \
  function [win,aver]=dice(B)  \
  %Play the dice game B times  \
  gains=[-1,2,-3,4,-5,6];      \
  plays=unidrnd(6,B,1);        \
  win=sum(gains(plays));       \
  aver=win/B;                  \
");

evaluate(matlab, "[w,a]=dice(1000);")
res <- getVariable(matlab, c("w", "a"))
print(res)

# When done, close the Matlab client, which will also shutdown
# the Matlab server and the connection to it.
close(matlab)

