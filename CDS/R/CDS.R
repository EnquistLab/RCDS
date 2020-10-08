#'Check for geographic centroids
#'
#'Submits latitude/longitude coordinates to the centroid detection service
#' @param coordinates Data.frame or matrix containing two columns: latitude and longitude (in that order).
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
CDS <- function(coordinates){

  # Set API options
    mode <- "resolve"										# Processing mode

  # Base URL for CDS api
    url = "http://vegbiendev.nceas.ucsb.edu:8775/cds_api.php"

  # Convert the data to JSON
    data_json <- jsonlite::toJSON(unname(coordinates))

  # Convert the options to data frame and then JSON
    opts <- data.frame(c(mode))
    names(opts) <- c("mode")
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
