% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ct_cvdf.R
\name{ct_cvdf}
\alias{ct_cvdf}
\title{Find Contour Values for Several Images}
\usage{
ct_cvdf(imagepaths, color = "red")
}
\arguments{
\item{imagepaths}{A vector or data frame object containing the file paths to the images for analysis. If inputting a data frame, the data frame can have other columns if desired, but the file paths must be in a column called "File".}

\item{color}{A character string for the color of the superimposed object. Default is red.}
}
\value{
A data frame containing the file paths and selected contour values.
}
\description{
An interactive function for locating pixels corresponding to edges in multiple photos. If the default contour value (0.1) does not display desired contours, input "N" when prompted to input a new contour value and redisplay. Repeat as necessary until it is satisfactory, then input "Y". The selected contour value(s) will be saved to a data frame.
}
