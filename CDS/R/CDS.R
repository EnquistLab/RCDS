#'Check for geographic centroids
#'
#'Submits latitude/longitude coordinates to the centroid detection service
#' @param coordinates Data.frame or matrix containing two columns: latitude and longitude (in that order).
#' @param maxdist NULL or Numeric. Maximum distance from centroid to qualify as centroid. If NULL, will use the current default.
#' @param maxdistrel NULL or Numeric. Maximum relative distance from centroid (relative to distance from centroid  to farthest point in political division), to qualify as a centroid. If NULL, will use the current default.
#' @param batches NULL or Integer. Number of batches to divide input into for parallel processing. If NULL, will use the current default.
#' @return Data.frame containing CDS output.
#' @import RCurl
#' @importFrom jsonlite toJSON fromJSON
#' @export
#' @examples {
#' # Test file from BIEN website:
#' coordinates <-
#' read.csv("https://bien.nceas.ucsb.edu/bien/wp-content/uploads/2020/10/cds_testfile.csv",
#' stringsAsFactors = FALSE)
#' CDS_output <- CDS(coordinates)
#' }
#'
CDS <- function(coordinates,maxdist=NULL,maxdistrel=NULL, batches = NULL){

  # Set API options
    mode <- "resolve"										# Processing mode

  # Base URL for CDS api
    url = "http://vegbiendev.nceas.ucsb.edu:8775/cds_api.php"

  # Convert the data to JSON
    data_json <- jsonlite::toJSON(unname(coordinates))


  # Convert the options to data frame and then JSON
    opts <- data.frame(c(mode))
    names(opts) <- c("mode")
    if ( !is.null( maxdist ) ){ opts$maxdist <- maxdist}
    if ( !is.null( maxdistrel ) ){ opts$maxdistrel <- maxdistrel}
    if ( !is.null( batches ) ){ opts$batches <- batches}

    opts_json <-  jsonlite::toJSON(opts)
    opts_json <- gsub('\\[','',opts_json)
    opts_json <- gsub('\\]','',opts_json)

  # Combine the options and data into single JSON object
    input_json <- paste0('{"opts":', opts_json, ',"data":', data_json, '}' )

  # Construct the request
    headers <- list('Accept' = 'application/json', 'Content-Type' = 'application/json', 'charset' = 'UTF-8')

  # Send the API request
    results_json <- postForm(url, .opts=list(postfields= input_json, httpheader=headers))

  # Convert JSON results to a data frame
    results <-  jsonlite::fromJSON(results_json)


  return(results)

}#TNRS citations
