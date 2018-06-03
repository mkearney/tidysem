

fit_lavaan <- function(m) {
  n <- m@Data@nobs[[1]]
  f <- lavaan::fitMeasures(m,
    fit.measures = c("chisq", "df", "pvalue", "cfi", "tli",
      "aic", "bic", "rmsea", "srmr"))
  r2 <- lavaan::inspect(m, "rsquare")
  r2 <- r2[!names(r2) %in% lavaan::varTable(m)[, 1]]
  r2nms <- paste0("R^2:", names(r2))
  fit_statistic <- c("chisq", "aic", "bic", "cfi", "tli", "rmsea", "srmr", r2nms)
  p <- rep(NA_real_, length(fit_statistic))
  p[match("chisq", fit_statistic)] <- f[3]
  df <- rep(NA_integer_, length(fit_statistic))
  df[match("chisq", fit_statistic)] <- as.integer(f[2])
  f <- c(f[!names(f) %in% c("df", "pvalue")], r2)
  stars <- make_stars(p)
  tibble::data_frame(fit_stat = fit_statistic, n, df,
    estimate = f, p.value = p, stars)
}
