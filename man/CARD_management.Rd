% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CARD_management.R
\name{CARD_management}
\alias{CARD_management}
\title{CARD_management}
\usage{
CARD_management(
  CARD_path = system.file("CARD", package = "EXstat"),
  CARD_tmp = tempfile(),
  CARD_dir = "WIP",
  CARD_name = c("QA", "QJXA"),
  layout = c(CARD_dir, "[", CARD_name, "]"),
  underscore_to_white = TRUE,
  add_id = TRUE,
  overwrite = TRUE,
  verbose = FALSE,
  args = list(CARD_path = CARD_path, CARD_tmp = CARD_tmp, layout = layout,
    underscore_to_white = underscore_to_white, add_id = add_id, overwrite = overwrite,
    verbose = verbose)
)
}
\arguments{
\item{CARD_path}{A \link[base:character]{character} string representing the path to the downloaded CARD directory (it should end with \code{"CARD"}). In this directory, you can search the CARDs that you want in the \code{"__all__"} subdirectory that will be use for an analysis (see \link{layout} to know how to specify which CARD you want).}

\item{CARD_tmp}{A \link[base:character]{character} string for a path to a directory where the CARD parameterization files will be copied and pasted for an analysis. Default is \code{NULL} if you want to use a \code{tmp} subdirectory in the \code{CARD_path} directory.}

\item{CARD_dir}{A \link[base:character]{character} string for the name of a subdirectory in \code{CARD_path} (or \code{CARD_tmp}) where the CARD parameterization files are located for an analysis. Default is \code{"WIP"}.}

\item{CARD_name}{A \link[base:c]{vector} of \link[base:character]{character} strings with the names of the CARDs to be used. Default is \code{c("QA", "QJXA")}.}

\item{layout}{A \link[base:character]{character} string \link[base:c]{vector} specifying the tree structure of files that you want for your analysis. Each element of the vector represents either:
\itemize{
\item the name of an analysis directory (e.g., \code{"WIP"})
\item the beginning and ending of an analysis directory: \code{"["} for the start and \code{"]"} for the end
\item the CARD name (e.g., \code{"QA"})
For example, if you want to create an \code{"WIP"} analysis directory for the CARDs named \code{"QA"} and \code{"QJXA"}, you can provide \code{c("WIP", "[", "QA", "QJXA", "]")}. Default is \code{NULL} to use \code{CARD_dir} and \code{CARD_name}.
}}

\item{underscore_to_white}{\link[base:logical]{logical}. If \code{TRUE}, underscores in directory names will be replaced with spaces. Default is \code{TRUE}.}

\item{add_id}{\link[base:logical]{logical}. If \code{TRUE}, numerical IDs will be added to the start of the copied and pasted CARD names to maintain the input order. Default is \code{TRUE}.}

\item{overwrite}{\link[base:logical]{logical}. If \code{TRUE}, existing CARD files in the \code{CARD_tmp} directory will be overwritten. Default is \code{TRUE}.}

\item{verbose}{\link[base:logical]{logical}. Should intermediate messages be printed during the execution of the function ? Default \code{FALSE}.}

\item{args}{An intermediate form of arguments that is useful if the argparse package is used. If not provided, it will be automatically created using the other function arguments. Default is \code{NULL}.}
}
\value{
CARD parameterization files will be copied and pasted from \code{CARD_path} and organized according to the structure given by \link{layout} into the \code{CARD_tmp} directory.
}
\description{
Manage the CARD directory structure by performing automatic file operations to copy and paste CARD parameterization files more efficiently.
}
\examples{
\dontrun{
CARD_management(CARD_path="path/to/CARD",
                CARD_tmp="path/to/copy/CARD",
                CARD_dir="WIP",
                CARD_name=c("QA", "QJXA"),
                overwrite=TRUE,
                verbose=TRUE)
# or with layout
CARD_management(CARD_path="path/to/CARD",
                CARD_tmp="path/to/copy/CARD",
                layout=c("WIP", "[", "QA", "QJXA", "]"),
                overwrite=TRUE,
                verbose=TRUE)
}

}
\seealso{
\itemize{
\item \code{\link[=process_extraction]{process_extraction()}} for extracting variables.
\item \code{\link[=process_trend]{process_trend()}} for performing trend analysis on extracted variables.
\item \code{\link[=CARD_extraction]{CARD_extraction()}} for extracting variables using CARD parameterization files.
}
}
