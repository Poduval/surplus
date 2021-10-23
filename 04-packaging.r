# Build package ====
library(devtools)

# _ignoring package un related files ====
use_build_ignore(c('02-specifications', '04-packaging.R',
                   '05-release', "renv", 'renv.lock'))

document()
build(path = "05-release/", quiet = FALSE)
check(quiet = TRUE)
install()

# Test package ====
packageDescription("surplus")
news(package = "surplus")

library(surplus)
getNamespaceExports("surplus")

help("surplus")

?surplus
?surplus_irm

x <- surplus(seq(0, 10, 0.001), 4, 3, 30)
print(x, 20)
plot(x)

surplus_irm(seq(0, 1, 0.5))

# shiny app: require shiny package:
app_surplus()

lds:::app_surplus()
