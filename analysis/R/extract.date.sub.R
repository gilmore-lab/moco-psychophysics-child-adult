extract.date.sub <- function(fn="160402105932.csv"){
  fn = basename(fn)
  test.date <- substr(fn, 1, 6)
  sub.num <- substr(fn, 7, 10)
  block <- substr(fn, 11, 11)
  speed <- substr(fn, 12, 12)
  return(list(test.date, sub.num, block, speed))
}