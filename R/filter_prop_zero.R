#' Filter Genes for by Max Proportion Zero Among Groups
#'
#' This function uses the `data.frame()` generated to find the maximum Proportion
#' Zero across groups, then filter to a set of genes that pass the max Prop Zero
#' cutoff defined by the user.
#'
#' @param prop_zero_df `data.frame()` containing proportion of zero counts, genes as
#' rows, groups as columns.
#' @param cutoff A `numeric()` cutoff value for maximum Proportion Zero.
#' The cutoff value should be < 1.
#' @param na.rm a logical indicating whether missing values should be removed
#' when max prop_zero is calculated.
#' @return A `character()` of gene names that are under the cutoff.
#' These names are from the `rownames()` of the expression data.
#' @export
#'
#' @examples
#' ## Get Proportion Zero data.frame
#' prop_zero <- get_prop_zero(sce_zero_test, group_col = "group")
#'
#' ## Filter with max Proportion Zero cutoff = 0.59
#' filter_prop_zero(prop_zero, cutoff = 0.59)
#'
#' ## NA handling
#' prop_zero[1, 1] <- NA
#'
#' ## If NA are present in the prop_zero_df the user can choose to:
#'
#' ## Remove NAs (default)
#' ## genes with NA counts may be included in the final list
#' filter_prop_zero(prop_zero, cutoff = 0.59, na.rm = TRUE)
#'
#' ## Include NA values
#' ## any gene with genes with NA counts (so max prop_zero will be NA)
#' ## will be removed from the final list, this will throw warning
#' filter_prop_zero(prop_zero, cutoff = 0.59, na.rm = FALSE)
#'
#' @family Proportion Zero functions
filter_prop_zero <- function(prop_zero_df, cutoff = 0.9, na.rm = TRUE) {
    stopifnot(is.data.frame(prop_zero_df))
    stopifnot(!is.null(rownames(prop_zero_df)))
    stopifnot(is.numeric(unlist(prop_zero_df)))
    stopifnot(is.numeric(cutoff))
    stopifnot(cutoff <= 1)

    max_prop_zero <- apply(prop_zero_df, 1, max, na.rm = na.rm)
    if (any(is.na(max_prop_zero))) {
        warning("NAs present in Max prop zero")
        max_prop_zero <- max_prop_zero[!is.na(max_prop_zero)]
    }
    filter_prop <- max_prop_zero[max_prop_zero < cutoff]

    if (length(filter_prop) == 0) warning("The provided cutoff (", cutoff, ") filters out every gene")

    return(names(filter_prop))
}
