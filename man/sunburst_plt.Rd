% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils_home.R
\name{sunburst_plt}
\alias{sunburst_plt}
\title{Create a Sunburst Plot}
\usage{
sunburst_plt(
  df,
  vars,
  max_depth = Inf,
  opacity = 1,
  branchvalues = "total",
  source_id = "A"
)
}
\arguments{
\item{df}{A data frame containing the data to be visualized.}

\item{vars}{A character vector specifying the variables to use for generating
the sunburst plot.}

\item{max_depth}{The maximum depth of the sunburst plot. Defaults to Inf (no
depth limit).}

\item{opacity}{The opacity of the plot elements. Should be a value between 0
and 1.}

\item{branchvalues}{The value to determine how the branches are computed.
Should be either "remainder" or "total".}

\item{source_id}{a character string of length 1. Match the value of this
string with the source argument in event_data() to retrieve the event data
corresponding to a specific plot (shiny apps can have multiple plots).}
}
\value{
A Plotly sunburst plot.
}
\description{
This function generates a sunburst plot using the Plotly library, based on
the provided data frame and variables.
}
