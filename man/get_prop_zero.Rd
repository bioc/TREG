% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_prop_zero.R
\name{get_prop_zero}
\alias{get_prop_zero}
\title{Get the Proportion of Zero Counts for Each Gene in Each Group}
\usage{
get_prop_zero(sce, group_col = "cellType")
}
\arguments{
\item{sce}{\link[SummarizedExperiment:SummarizedExperiment-class]{SummarizedExperiment-class} object}

\item{group_col}{name of the column in the
\link[SummarizedExperiment:SummarizedExperiment-class]{colData()} of \code{sce}
that defines the group of interest.}
}
\value{
A \code{data.frame()} containing proportion of zero counts, genes as rows,
groups as columns.
}
\description{
This function calculates the Proportion Zero for each gene in each user defined group.
Proportion Zero = number of zero counts for a gene for a group of cells/number of cells in the group.
}
\details{
For more information about calculating Proportion Zero, check equation 1 from
the vignette in section "Calculate Proportion Zero and Pick Cutoff".
}
\examples{
## Basic Proportion counts == 0
rowSums(assays(sce_zero_test)$counts == 0) / ncol(sce_zero_test)

## Get proportion by the default group "cellType"
get_prop_zero(sce_zero_test)

## Get proportion by user defined grouping of the data
get_prop_zero(sce_zero_test, group_col = "group")

## Groups with missing levels will be dropped
get_prop_zero(sce_zero_test, group_col = "cellType_na")
}
\seealso{
Other Proportion Zero functions: 
\code{\link{filter_prop_zero}()}
}
\concept{Proportion Zero functions}
