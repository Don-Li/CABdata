#' variable_interval_1_2017 dataset (\code{tibble} version)
#'
#' This is the same dataset as \link{variable_interval_1_2017}, but with less specialised data strutures for storing things like the event reocrd. For example, instead of a \code{formal_event_record} from the \code{CAB} package, a \code{tibble} is used, which is essentially a \code{data.frame}.
#'
#' @seealso
#' \link{variable_interval_1_2017} for documentation for this dataset.
#' \code{\link{tibble}} for more information about \code{tibble}.
#'
#' @examples
#' # code for creating this dataset
#' data( variable_interval_1_2017 )
#' working_data = data.table::copy( variable_interval_1_2017 )
#' event_records = working_data[ , event_record ]
#' event_record_tibbles = lapply( event_records, function(x) as_tibble( x@events ) )
#' arranged_vis = working_data[ , arranged_vi ]
#' arranged_vis_tibbles = lapply( arranged_vis, function(x) as_tibble( x ) )
#' variable_interval_1_2017_tibble = as_tibble( working_data )
#' variable_interval_1_2017_tibble[ , "event_record" ] = lst( event_record_tibbles )
#' variable_interval_1_2017_tibble[ , "arranged_vi" ] = lst( arranged_vis_tibbles )
#'
#' # Save the data
#' save( variable_interval_1_2017_tibble, file = "variable_interval_1_2017_tibble.RData")
#'
#' @name variable_interval_1_2017_tibble
#' @docType data
#' @usage data(variable_interval_1_2017_tibble)
#' @format A \code{data.table}.
#' @keywords variable_interval tibble

NULL
