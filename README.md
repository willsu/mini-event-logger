Mini Event Logger is a tiny Ruby program that listens on a TCP socket and logs any data it receives. 

The following example uses Cloud Foundry to provide a cheap log aggregator through the use of a User Provided Service and application Service Bindings. The expected result is that the logs for any bound CF application be written to the deployed Mini Event Logger. Although the Mini Event Logger does not implement the `syslog` protocol, the program does function as a TCP server for a syslog client. 

Note: This tool is experimental and intended for use in development environments only.

```
# navigate to the mini-event-logger dir
cd ~/mini-event-logger # <-- or wherever you have cloned the git project

# deploy the Ruby logger to cf 
cf push

# locate a CF domain that supports TCP connections
cf domains

# map a TCP route to the deployed application
# replace $MY_TCP_DOMAIN with the correct domain
cf map-route mini-event-logger $MY_TCP_DOMAIN --random-port 

# create a user provided service for logging by using the -l option and configure the host and port mapped to the mini-event-logger
# replace $MY_TCP_DOMAIN with the correct domain
# replace $MY_TCP_PORT with the correct port 
cf cups mini-event-logger-service -l syslog://$MY_TCP_DOMAIN:$MY_TCP_PORT

# bind application 1 to the logger ups
cf bind-service app1 mini-event-logger-service
cf restage app1

# bind application 2 to the logger ups
cf bind-service app2 mini-event-logger-service
cf restage app2

# view the logs for app1 and app2 from the mini-event-logger app
cf logs mini-event-logger
```
