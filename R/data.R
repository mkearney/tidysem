data_lavaan <- function(x) {
  d <- as_tbl(x@Data@X[[1]])
  names(d) <- x@Data@ov.names[[1]]
  p <- tryCatch(lavaan::predict(x), error = function(e) return(NULL))
  if (is.null(p)) return(tbl_frame())
  p <- as_tbl(p)
  nms <- names(p)
  names(p) <- paste0(".", nms)
  as_tbl(cbind(d, p))
}
