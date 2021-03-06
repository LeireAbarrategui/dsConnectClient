#This script determine all the login information to the servers used for the testing. 
#The first time, you will need to edit the server_ip_address. The latter is required to set 
#access to the data on the virtual machines. 


source("connection_to_datasets/init_local_settings.R")

set_config( config( ssl_verifypeer = 0L ) )
set_config( config( ssl_verifyhost = 0L ) )
init.ip.address()
#ds.test_env <- new.env()
#options(datashield.env=ds.test_env)

  ds.test_env$contexts <- c('opal','dsi','dslite','continuous','coverage')  

  ds.test_env$server_ip_address = init.ip.address()
  
 #ds.test_env$context = 'opal'
  ds.test_env$context = 'dsi'

  ds.test_env$ip_address_1 <- paste("https://", ds.test_env$server_ip_address, ":8443", sep="")
  ds.test_env$ip_address_2 <- paste("https://", ds.test_env$server_ip_address, ":8443", sep="")
  ds.test_env$ip_address_3 <- paste("https://", ds.test_env$server_ip_address, ":8443", sep="")

  #This TCP/IP address is required to test a connect to the server. 
  ds.test_env$ping_address <- paste("http://", ds.test_env$server_ip_address, ":8080", sep="" )

  ds.test_env$user_1 <- "administrator"
  ds.test_env$user_2 <- "administrator"
  ds.test_env$user_3 <- "administrator"

  ds.test_env$password_1 <- "datashield_test&"
  ds.test_env$password_2 <- "datashield_test&"
  ds.test_env$password_3 <- "datashield_test&"
  ds.test_env$driver <- "OpalDriver"
  ds.test_env$secure_login_details = TRUE


build.all.ip.addresses <- function()
{
  return(c(ds.test_env$ip_address_1,ds.test_env$ip_address_2,ds.test_env$ip_address_3))
}

build.all.users <- function()
{
  return(c(ds.test_env$user_1,ds.test_env$user_2,ds.test_env$user_3))
}

build.all.passwords <- function()
{
  return(c(ds.test_env$password_1,ds.test_env$password_2,ds.test_env$password_3))
}

build.all.datasets <- function()
{
  return(c("TESTING.DATASET1", "TESTING.DATASET2", "TESTING.DATASET3"))
}

build.all.ssl <- function()
{
  return(c("c(ssl.verifyhost=0,ssl.verifypeer=0)","c(ssl.verifyhost=0,ssl.verifypeer=0)","c(ssl.verifyhost=0,ssl.verifypeer=0)"))
}

build.all.drivers <- function()
{
  return(c("OpalDriver","OpalDriver","OpalDriver"))
}
