% Generated by roxygen2 (4.0.2): do not edit by hand
\name{keys}
\alias{as.key}
\alias{key}
\alias{keys}
\title{List your ssh keys, or get a single key}
\usage{
keys(..., page = 1, per_page = 25)

key(x, ...)

as.key(x)
}
\arguments{
\item{...}{Additional arguments passed down to low-level API function
(\code{do_*})}

\item{page}{Page to return}

\item{per_page}{Number of results per page}

\item{x}{For \code{key} the numeric id. For \code{as.key}, a number (the id),
a string (the name), or a key.}
}
\description{
List your ssh keys, or get a single key
}
\examples{
\dontrun{
keys()
as.key(328037)
as.key("hadley")
}
}

