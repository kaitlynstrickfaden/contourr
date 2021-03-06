
#' Find Contour Values for Several Images
#'
#' An interactive function for locating pixels corresponding to edges in multiple photos. If the default contour value (0.1) does not display desired contours, input "N" when prompted to input a new contour value and redisplay. Repeat as necessary until it is satisfactory, then input "Y". The selected contour value(s) will be saved to a data frame.
#'
#' @importFrom graphics par plot
#' @importFrom stringr str_glue
#' @import dplyr
#' @import grDevices
#' @import imager
#' @param imagepaths A vector or data frame object containing the file paths to the images for analysis. If inputting a data frame, the data frame can have other columns if desired, but the file paths must be in a column called "File".
#' @param color A character string for the color of the superimposed object. Default is red.
#' @return A data frame containing the file paths and selected contour values.
#' @export




ct_cvdf <- function(imagepaths, color = "red") {


  if (is.vector(imagepaths)) {
    for (i in seq_along(imagepaths)) {
      if (file.exists(imagepaths[i]) == FALSE) {
        stop(str_glue("imagepaths[", i, "] is not a valid path.", sep = "")) }
    }
    d <- data.frame(File = imagepaths, CV = 0)
  }


  if (is.data.frame(imagepaths)) {
    d <- imagepaths
    if ("File" %in% colnames(d) == FALSE) {
      stop("input data frame must contain a column called 'File'") }
    for (i in seq_along(d$File)) {
      if (file.exists(d$File[i]) == FALSE) {
        stop(str_glue("imagepaths$File[", i, "] is not a valid path", sep = "")) }
    }
    d$CV <- 0
  }


  if (is.vector(imagepaths) == FALSE & is.data.frame(imagepaths) == FALSE) {
    stop("'imagepaths' must be a vector or data frame object")
  }


  for (i in seq_along(d$File)) {

    done <- FALSE
    refimage <- d$File[i]
    cv <- .1
    roi_in <- grabRect(imager::load.image(refimage), output = "coord")
    roi_in <- data.frame(roi_in[1], roi_in[2], roi_in[3], roi_in[4])

    ct_find(refimage, roi_in = roi_in, contour_value = cv, color = color)

    while (done == FALSE) {

      interactive()

      x <- readline(prompt = "Is this a good contour value? Input Y for yes or N for no: ")

      if (x == "Y") {
        d[i,"CV"] <- cv
        done <- TRUE
      }

      if (x != "Y") {
        cv <- as.numeric(readline(prompt = "Input new contour value: "))
        ct_find(refimage, roi_in = roi_in, contour_value = cv, color = color)
        done <- FALSE
      }

    } # end of while loop

  } # end of for loop

  return(d)

} # end of function


