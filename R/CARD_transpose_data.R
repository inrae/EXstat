#' Transpose dataEX data.frame returned by CARD_extraction
#'
#'
#' @param dataEX A [data.frame] returned by CARD_extraction with argument `simplify=TRUE`
#'
#' @returns The transposed data frame with the first column as 'name' and following columns with the ID of the time series.
#'
#' @export
#'
CARD_transpose_data <- function(dataEX) {
  stopifnot(is.data.frame(dataEX))
  # Step 1: Extract the 'name' value
  id <- dataEX$name

  # Step 2: Drop the 'name' column and transpose the rest
  transposed <- as.data.frame(t(dataEX[ , -1]))

  # Step 3: Convert to data.frame and add row names as a column
  transposed_df <- data.frame(name = rownames(transposed), value = transposed[[1]])
  colnames(transposed_df)[2] <- id  # Rename the second column with the ID value

  # Reset rownames
  rownames(transposed_df) <- NULL
  return(transposed_df)
}
