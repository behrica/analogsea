% Generated by roxygen2 (4.0.2): do not edit by hand
\name{droplet_ssh}
\alias{droplet_ssh}
\title{Remotely execute ssh code on a droplet.}
\usage{
droplet_ssh(droplet, cmd, user = "root", verbose = FALSE)
}
\arguments{
\item{droplet}{A droplet, or something that can be coerced to a droplet by
\code{\link{as.droplet}}.}

\item{cmd}{Shell command to run}

\item{user}{User}
}
\description{
Assumes that you have ssh installed, and password-less login set up
on the droplet.
}
\examples{
\dontrun{
d <- droplet_new() \%>\% droplet_wait()
d \%>\% droplet_ssh("apt-get update")
d \%>\% droplet_ssh("sudo apt-get upgrade -y")
d \%>\% droplet_ssh("apt-get autoremove -y")
}
}
