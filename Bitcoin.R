# import library 
library(prophet)
library(tidyverse)
library(dplyr)

# ອ່ານໄຟຣ໌ **BTC_USD.csv** ເຂົ້າໃສ່ **bitcoi**
bitcoin <- read_csv("../examples/example/BTC_USD.csv")
head(bitcoin)
tail(bitcoin)

# ປ່ຽນຊື່ Column: 
#**Date -> "ds"** 
#**Closing Price (USD) -> "y"**
#ເພືື່ອທີ່ຈະເອົາໄປວິເຄາະດ້ວຍ **Prophet**

names(bitcoin)[names(bitcoin) == "Date"] <- "ds"
names(bitcoin)[names(bitcoin) == "Closing Price (USD)"] <- "y"


#ສະແດງກຣາຟ **ລາຄາBitcoin** ຈາກຂໍ້ມູນທີ່ເຮົາໂຫຼດ

ggplot(bitcoin, aes(ds,y)) + geom_line() + xlab("Year") +ylab("Price")


# ສ້າງ Data frame ທີ່ຊື່ວ່າ BTC ເຊິ່ງເລືອກເອົາ **'ds','y'** ຈາກ bitcoin

BTC <- bitcoin %>% select(2:3)


# fit model ດ້ວຍ Prophet

Model1 <- prophet(BTC)

# ຈາກນັ້ນການວິເຄາະຈະຖືກສ້າງຂຶ້ນໃນ data frame future1 ໂດຍມີຖັນ ds ທີ່ມີວັນທີທີ່ຈະວິເຄາະ

Future1 <- make_future_dataframe(Model1, periods = 365)

# ວິທີການວິເຄາະ

Forecast1 <- predict(Model1, Future1)
tail(Forecast1[c('ds','yhat','yhat_lower','yhat_upper')])

# ສ້າງກຣາຟທີ່ໄດ້ຈາກການວິເຄາະ

dyplot.prophet(Model1, Forecast1)

# ສ້າງກຣາຟທີ່ໄດ້ຈາກການວິເຄາະເຊິ່ງຈະສະແດງເປັນຊ່ວງເວລາຕ່າງໆ

prophet_plot_components(Model1, Forecast1)