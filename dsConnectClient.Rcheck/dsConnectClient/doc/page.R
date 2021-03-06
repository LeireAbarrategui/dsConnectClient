## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(comment="", warning=FALSE, message=FALSE, cache=TRUE)

## -----------------------------------------------------------------------------
#Libraries 
library(DSI)
library(DSOpal)
library(httr)
library(ds.client.connection.server)
library(dsBaseClient)

## -----------------------------------------------------------------------------
#Only for windows users
#Sys.setenv(CURL_SSL_BACKEND = "openssl")

## -----------------------------------------------------------------------------
server.names <- c("Paris", "Newcastle", "New York")

## -----------------------------------------------------------------------------
url_Paris     <- 'https://192.168.56.100:8443'
url_Newcastle <- 'https://192.168.56.100:8443'
url_NewYork   <- 'https://192.168.56.100:8443'
server.urls     <- c(url_Paris,url_Newcastle,url_NewYork)

## -----------------------------------------------------------------------------
table_Paris     <- "TESTING.DATASET1"
table_Newcastle <- "TESTING.DATASET2"
table_NewYork   <- "TESTING.DATASET3"
server.tables   <- c(table_Paris, table_Newcastle, table_NewYork)

## -----------------------------------------------------------------------------
user_Paris      <-  "administrator"
user_Newcastle  <-  "administrator"
user_NewYork    <-  "administrator"
server.users.id <- c(user_Paris, user_Newcastle, user_NewYork)

## -----------------------------------------------------------------------------
password_Paris      <-  "datashield_test&"
password_Newcastle  <-  "datashield_test&"
password_NewYork    <-  "datashield_test&"
server.users.pwd    <-  c(password_Paris, password_Newcastle, password_NewYork)

## -----------------------------------------------------------------------------
ssl_options_Paris     <- "list(ssl_verifyhost=0,ssl_verifypeer=0)"
ssl_options_Newcastle <- "list(ssl_verifyhost=0,ssl_verifypeer=0)"
ssl_options_NewYork   <- "list(ssl_verifyhost=0,ssl_verifypeer=0)"
server.ssl.options    <- c(ssl_options_Paris,ssl_options_Newcastle,ssl_options_NewYork)

## -----------------------------------------------------------------------------
driver_Paris     <- "OpalDriver"
driver_Newcastle <- "OpalDriver"
driver_NewYork   <- "OpalDriver"
server.drivers   <- c(driver_Paris,driver_Newcastle,driver_NewYork)

## -----------------------------------------------------------------------------
login.data <- ds.build.login.data.frame(server.names,
                                        server.urls,
                                        server.tables,
                                        server.users.id,
                                        server.users.pwd,
                                        server.ssl.options,
                                        server.drivers)
print(login.data)

## -----------------------------------------------------------------------------
server.var <- list('ID','CHARACTER', 'LOGICAL','NA_VALUES','INTEGER','NULL_VALUES',
                   'NON_NEGATIVE_INTEGER','POSITIVE_INTEGER','NEGATIVE_INTEGER',
                   'NUMERIC', 'NON_NEGATIVE_NUMERIC','POSITIVE_NUMERIC','NEGATIVE_NUMERIC',
                   'FACTOR_CHARACTER','FACTOR_INTEGER','IDENTIFIER','CATEGORY','IDENTIFIER',
                   'CATEGORY')
connections <- ds.login(login.data, variables = server.var, symbol = 'D')
print(connections)



## -----------------------------------------------------------------------------
tables.colnames <- ds.colnames(x = 'D', 
                               datasources = connections)
print("Columns names    : ")
print(tables.colnames)
tables.features  <- ds.dim(x = "D", 
                           type = "split", 
                           datasources = connections)
print("Rows and columns : ")
print(tables.features)

## -----------------------------------------------------------------------------
int.mean    <- ds.mean (x = 'D$POSITIVE_INTEGER', type = "split", datasources = connections)
int.var     <- ds.var (x = 'D$POSITIVE_INTEGER', type = "split", datasources = connections)
int.std     <- sqrt(int.var[[1]][,1])

print("Mean")
print(int.mean[[1]])

print("Standard deviation")
print(int.std)

## -----------------------------------------------------------------------------
tables.colnames <- ds.colnames(x = 'D', 
                               datasources = connections)
print("Columns names    : ")
print(tables.colnames)
tables.features  <- ds.dim(x = "D", 
                           type = "combined", 
                           datasources = connections)
print("Rows and columns : ")
print(tables.features)

## -----------------------------------------------------------------------------
int.mean    <- ds.mean (x = 'D$POSITIVE_INTEGER', type = "combined", datasources = connections)
int.var     <- ds.var (x = 'D$POSITIVE_INTEGER', type = "combined", datasources = connections)
int.std     <- sqrt(int.var[[1]][,1])

print("Mean")
print(int.mean[[1]])

print("Standard deviation")
print(int.std)


## -----------------------------------------------------------------------------
#server function header 
server.function.call <- call("rUnifDS",100,14,50,10)
var.created <- ds.assign.value(new.variable.name= "rUnifDist",
                               value = server.function.call,
                               class.type = "numeric",
                               asynchronous = FALSE,
                               datasources = connections)
print(var.created)
print(ds.class(x = "rUnifDist", datasources = connections))

var.created <- ds.assign.value(new.variable.name ="rUnifDistB",
                               value = server.function.call,
                               class.type = "character",
                               asynchronous = FALSE,
                               datasources = connections)
print(var.created)
print(ds.class(x = "rUnifDistB", datasources = connections))

runif.mean    <- ds.mean (x = 'rUnifDist', type = "split", datasources = connections)
runif.var     <- ds.var (x = 'rUnifDist', type = "split", datasources = connections)
runif.std     <- sqrt(runif.var[[1]][,1])

print("server-level")
print("Mean")
print(runif.mean[[1]])

print("Standard deviation")
print(runif.std)

print("virtually-joined")
runif.mean    <- ds.mean (x = 'rUnifDist', type = "combined", datasources = connections)
runif.var     <- ds.var (x = 'rUnifDist', type = "combined", datasources = connections)
runif.std     <- sqrt(runif.var[[1]][,1])

print("Mean")
print(runif.mean[[1]])

print("Standard deviation")
print(runif.std)


## -----------------------------------------------------------------------------
print("the variable has been created and should exists on the server. A correct answer should be TRUE")
rUnif.exists <- ds.exists.on.server(variable.name = "rUnifDist", 
                                    class.type    = "numeric",
                                    datasources   = connections)
print(rUnif.exists)

print("the variable has not been created and should exists on the server. A correct answer should be FALSE")
rUnif.exists <- ds.exists.on.server(variable.name = "rUnifDistB", 
                                    class.type    = "character",
                                    datasources   = connections)
print(rUnif.exists)

## -----------------------------------------------------------------------------

outcome <- ds.remove.variable(variable.name = "rUnifDist", class.type = "numeric", datasources = connections)
print(outcome)

outcome <- ds.remove.variable(variable.name = "rUnifDistB", class.type = "character", datasources = connections)
print(outcome)


## -----------------------------------------------------------------------------
server.function.call <- call('dimDS','D')
print(server.function.call)
outcome <- ds.aggregate(expression = server.function.call, asynchronous = FALSE, datasources = connections)
print(outcome)

## -----------------------------------------------------------------------------
outcome <- ds.logout(connections)
print(outcome)

