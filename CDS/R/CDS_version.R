#'Get metadata on current CDS version
#'
#'Return metadata about the current CDS version
#' @return Dataframe containing current CDS version number, build date, and code version.
#' @import RCurl
#' @importFrom jsonlite toJSON fromJSON
#' @export
#' @examples{
#' CDS_version_metadata <- CDS_version()
#' }
#'
CDS_version <- function(){

  # Base URL for CDS api
    url = "http://vegbiendev.nceas.ucsb.edu:8775/cds_api.php"

  #Set API mode
    mode <- "meta"

  # Re-form the options json again
  # Note that only 'mode' is needed
    opts <- data.frame(c(mode))
    names(opts) <- c("mode")
    opts_json <- jsonlite::toJSON(opts)
    opts_json <- gsub('\\[','',opts_json)
    opts_json <- gsub('\\]','',opts_json)

  # Make the options
  # No data needed
    input_json <- paste0('{"opts":', opts_json, '}' )

  # Construct the request
    headers <- list('Accept' = 'application/json', 'Content-Type' = 'application/json', 'charset' = 'UTF-8')


  # Send the request again
    results_json <- postForm(url, .opts=list(postfields= input_json, httpheader=headers))

  # Display the results
    results <- jsonlite::fromJSON(results_json)

  return(results)

}#TNRS version
