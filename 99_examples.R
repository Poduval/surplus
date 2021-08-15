
packageDescription("ds")
news(package = "ds")

library(ds)

x <- surplus(seq(0, 10, 0.001), 4, 3, 30)
print(x, 20)
plot(x)

# shiny app: require shiny package:
app_surplus()
ds:::app_surplus()
