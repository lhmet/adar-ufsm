# set-rlibs.R
set_rlibs <- function(lib_dir = ".R/libs", r_env = ".Renviron") {
  fp <- file.path("/home", Sys.info()[["user"]], lib_dir)
  dir.create(fp, recursive = TRUE)
  stopifnot(dir.exists(fp))

  r_env <- file.path("/home", Sys.info()[["user"]], r_env)
  file.create(r_env)
  stopifnot(file.exists(r_env))

  r_libs <- paste0("R_LIBS=", r_env)
  write(r_libs, r_env)
}
