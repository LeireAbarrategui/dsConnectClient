% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ds.error.R
\name{ds.error}
\alias{ds.error}
\title{Displays DataSHIELD R session errors}
\usage{
ds.error(error, client = TRUE)
}
\arguments{
\item{error}{The error thrown by R}

\item{client}{If TRUE the client-side code error is indicated. If FALSE server-side}
}
\value{
\code{ds.error} returns client-side or server-side errors.
}
\description{
Shows server-side and/or client-side error message.
}
