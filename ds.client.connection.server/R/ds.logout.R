#'@name ds.logout
#'@title log out from some DataSHIELD servers 
#'@description Clear the DataSHIELD R sessions and logout from DataSHIELD data repositories.
#'@param datasources a list of \code{\link{DSConnection-class}} objects obtained after login. 
#'@param Save DataSHIELD sessions on each server data repository (if feature is supported)
#' with provided ID (must be a character string).
#'@examples 
#' \dontrun{
#' 
#'   ## Version 6.2, for older versions see the Wiki
#'   # Connecting to the Opal servers
#' 
#'   # Load necessary client packages
#'   require('DSI')
#'   require('DSOpal')
#'   require('dsBaseClient')
#'   require('dsConnectClient')
#' 
#'   # Append login information for a specific server
#'   
#'     #Data computers name
#'     server.names   <- c("Paris", "Newcastle", "New York")
#'     
#'     # Data computers url
#'     url_Paris     <- 'https://192.168.56.100:8443'
#'     url_Newcastle <- 'https://192.168.56.100:8443'
#'     url_NewYork   <-  'https://192.168.56.100:8443'
#'     server.urls     <- c(url_Paris,url_Newcastle,url_NewYork)
#'     
#'     # Assign datasets
#'     table_Paris     <- "TESTING.DATASET1"
#'     table_Newcastle <- "TESTING.DATASET2"
#'     table_NewYork   <- "TESTING.DATASET3"
#'     server.tables   <- c(table_Paris, table_Newcastle, table_NewYork)
#'
#'     # Set user and password to access the DataSHIELD servers
#'     user_Paris      <-  "administrator"
#'     user_Newcastle  <-  "administrator"
#'     user_NewYork    <-  "administrator"
#'     server.users.id <- c(user_Paris, user_Newcastle, user_NewYork)
#'
#'     password_Paris      <-  "datashield_test&"
#'     password_Newcastle  <-  "datashield_test&"
#'     password_NewYork    <-  "datashield_test&"
#'     server.users.pwd    <-  c(password_Paris, password_Newcastle, password_NewYork)
#'     
#'     # Set drivers
#'     driver_Paris     <- "OpalDriver"
#'     driver_Newcastle <- "OpalDriver"
#'     driver_NewYork   <- "OpalDriver"
#'     server.drivers   <- c(driver_Paris,driver_Newcastle,driver_NewYork)
#'
#'     # Set SSL drivers
#'     ssl_options_Paris     <- "list(ssl_verifyhost=0,ssl_verifypeer=0)"
#'     ssl_options_Newcastle <- "list(ssl_verifyhost=0,ssl_verifypeer=0)"
#'     ssl_options_NewYork   <- "list(ssl_verifyhost=0,ssl_verifypeer=0)"
#'     server.ssl.options    <- c(ssl_options_Paris,ssl_options_Newcastle,ssl_options_NewYork)
#'       
#'     # Create login data frame
#'     login.data <- ds.build.login.data.frame(server.names,
#'                                             server.urls,
#'                                             server.tables,
#'                                             server.users.id,
#'                                             server.users.pwd,
#'                                             server.ssl.options,
#'                                             server.drivers)
#'   # Log in to DataSHIELD server                                         
#'   connections <- ds.login(login.data.frame = login.data, assign = TRUE, symbol = "D")
#'   
#'   # Clear the Datashield/R sessions and logout
#'   ds.logout(connections) 
#' }
#'  
#'@author Patricia Ryser-Welch for DataSHIELD development team 
#'@export ds.logout
#'


ds.logout <- function(datasources, save = NULL)
{
  outcome <- TRUE
  tryCatch(
     {.logout(datasources,save);},
      warning = function(warning) {.warning(warning)},
      error = function(error) {ds.error(error)},
      finally = {return(outcome)}
    )
}

.logout <- function(datasources, save)
{
  if(is.null(datasources))
  {
    stop("::ds.logout::ERR:006", call. = FALSE)
  }
  
  DSI::datashield.logout(datasources,save)
  
}


.warning <- function(message)
{
  message(paste("ds.client.connection.server::ds.logout :",   message ))
}

