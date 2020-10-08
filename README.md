# RCDS
R package for accessing the Centroid Detection Service.

The CDS Development API is ready for testing. Everything is on github in a single repository:

https://github.com/ojalaquellueva/cds

More specifically, you'll want to look in subdirectory api/ for api example files and documentation:

https://github.com/ojalaquellueva/cds/tree/master/api

Be sure to read the api-specific README. It has detailed descriptions of input format (simple) and definitions of output fields. Currently I return some fields users don't need. I'll get rid of those on the next round.

https://github.com/ojalaquellueva/cds/blob/master/api/README.md

The R package can be installed using devtools:

devtools::install_github("EnquistLab/RCDS/CDS")
