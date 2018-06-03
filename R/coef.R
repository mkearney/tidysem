
coef_lavaan <- function(m) {
  m <- as_tbl(lavaan::parameterEstimates(m, standardized = TRUE))
  m <- m[m$op != "~~", ]
  m$term <- apply(m[, 1:3], 1, paste, collapse = " ")
  m <- m[, c("term", "est", "se", "z", "pvalue",  "std.all")]
  names(m)[4:6] <- c("est.se", "p.value", "std.est")
  m <- add_stars(m)
  m[, c("term", "est", "se", "est.se", "p.value", "stars", "std.est")]
}

