#econocharts

#Paketi indirme
install.packages("devtools") #Ýndirilmemiþse indirebilirsiniz
devtools::install_github("R-CoderDotCom/econocharts") #econocharts paketini indirelim

#Paketi çaðýralým
library(econocharts)


#Arz grafiði
supply() # Varsayýlan grafik


supply(ncurves = 1,           # Kaç arz eðrisi çizilmesi gerekiyor?
       type = "line",         # Eðri tipi
       x = c(2, 4, 5),        # Kesiþimleri oluþturmak için y-ekseni deðerleri
       linecol = 2,           # Eðrilerin rengi
       geom = "label",        # Kesiþim noktalarýnýn etiket tipi
       geomfill = "pink",     # Eðer geom = "label" argümaný girilmiþse, etiketin arka plan rengi
       main = "Supply curve") # Grafik baþlýðý


supply(ncurves = 3, # 3 arz eðrisi olsun
       xlab = "X",  # X ekseni baþlýðý
       ylab = "Y",  # Y ekseni baþlýðý
       bg.col = "lightblue") # Arkaplan rengi


#----------------------------------------------------------------------------------------------
#Talep grafiði

demand(x = 3:6,  # Kesiþimler
       generic = FALSE) # Sayý deðerleriyle eksen etikerleri


demand(main = "Demand", # Baþlýk
       sub = "curve",   # Alt baþlýk
       xlab = "X",      # X-ekseni etiketi
       ylab = "Y",      # Y-ekseni etiketi
       names = "D[1]",  # Eðri baþlýðý
       geomcol = 2)     # Eðri baþlýðýnýn rengi


#---------------------------------------------------------------------------------------------
#Arz ve talep grafiði

sdcurve() #Varsayýlan grafik


# Kendi verimizi oluþturalým
supply1 <- data.frame(x = c(1, 9), y = c(1, 9))
supply1

demand1 <- data.frame(x = c(7, 2), y = c(2, 7))
demand1

supply2 <- data.frame(x = c(2, 10), y = c(1, 9))
supply2

demand2 <- data.frame(x = c(8, 2), y = c(2, 8))
demand2

p <- sdcurve(supply1,   # Verilerimizi ilgili fonksiyona argüman olarak giriyoruz
             demand1,
             supply2, 
             demand2,
             equilibrium = TRUE, # Dengeyi hesaplatýyoruz
             bg.col = "#fff3cd") # Arkaplan rengini belirleyelim
p + ggplot2::annotate("segment", x = 2.5, xend = 3, y = 6.5, yend = 7,                # Grafiðe ok ekleyelim
             arrow = grid::arrow(length = grid::unit(0.3, "lines")), colour = "grey50")


#----------------------------------------------------------------------------------------------

#Kayýtsýzlýk eðrileri

indifference() # Varsayýlan grafik


indifference(ncurves = 2,  # 2 eðri olsun
             x = c(2, 4),  # Kesiþimler
             main = "Indifference curves", # Grafik baþlýðý
             xlab = "Good X", # X ekseni baþlýðý
             ylab = "Good Y", # Y ekseni baþlýðý
             linecol = 2,  # Eðri renkleri
             pointcol = 2) # Kesiþim noktalarýnýn rengi

#-------------------------
p <- indifference(ncurves = 2, x = c(2, 4), main = "Indifference curves", xlab = "Good X", ylab = "Good Y") # Kayýtsýzlýk eðrisi

int <- dplyr::bind_rows(curve_intersect(data.frame(x = 1:1000, y = rep(3, nrow(p$curve))), p$curve + 1)) # Kesiþimler

p$p + ggplot2::geom_segment(data = int, ggplot2::aes(x = 0, y = y, xend = x, yend = y), lty = "dotted")  + # Kesikli çizgilerin eklenmesi
  ggplot2::geom_segment(data = int, ggplot2::aes(x = x, y = 0, xend = x, yend = y), lty = "dotted") +
  ggplot2::geom_point(data = int, size = 3)
#-------------------------

indifference(ncurves = 2,    # Ýki eðri çizdir
             type = "pcom",  # Mükemmel tamamlayýcý
             main = "Indifference curves", # Grafik baþlýðý
             sub = "Perfect complements", # Grafik alt baþlýðý
             xlab = "Good X", # X ekseni baþlýðý
             ylab = "Good Y", # Y ekseni baþlýðý
             bg.col = "#fff3cd", # Arkaplan rengi
             linecol = 1)  # Eðri rengi
#---------------------------

indifference(ncurves = 5,     # 5 eðri çizdir
             type = "psubs",  # Mükemmel tamamlayýcýlar
             main = "Indifference curves", #Grafik baþlýðý
             sub = "Perfect substitutes", # Alt baþlýk
             xlab = "Good X", # X ekseni baþlýðý
             ylab = "Good Y", # Y ekseni baþlýðý
             bg.col = "#fff3cd", # Arkaplan rengi
             linecol = 1) # Eðri rengi

#------------------------------------------------------------------------------------------------------
# Üretim Ýmkanlarý Eðrisi (Production–possibility frontier)

ppf(x = 1:6, # Kesiþimler
    main = "PPF", # Grafik baþlýðý
    geom = "text", # Eksenlerde text formatýnda tikler olsun
    generic = TRUE, # Jenerik eksen etiketleri
    xlab = "X", # X ekseni baþlýðý
    ylab = "Y", # Y ekseni baþlýðý
    labels = 1:6, # Kesiþim noktalarý etiketleri
    acol = 3) # Eðri altýndaki alan rengi

#--------------------
p <- ppf(x = 4:6, # Kesiþimler
         main = "PPF", # Grafik baþlýðý
         geom = "text", # Eksenlerde text formatýnda tikler olsun
         generic = TRUE, # Jenerik etiketler
         labels = c("A", "B", "C"), # Etiketler
         xlab = "BIKES", # X ekseni baþlýðý
         ylab = "CARS", # Y ekseni baþlýðý
         acol = 3)      # Grafik altýnda kalan alan

p$p + ggplot2::geom_point(data = data.frame(x = 5, y = 5), size = 3) + #ggplot2 yardýmý ile oklarýn eklenmesi
  ggplot2::geom_point(data = data.frame(x = 2, y = 2), size = 3) +
  ggplot2::annotate("segment", x = 3.1, xend = 4.25, y = 5, yend = 5,
           arrow = grid::arrow(length = grid::unit(0.5, "lines")), colour = 3, lwd = 1) +
  ggplot2::annotate("segment", x = 4.25, xend = 4.25, y = 5, yend = 4,
           arrow = grid::arrow(length = grid::unit(0.5, "lines")), colour = 3, lwd = 1)

#------------------------------------------------------------------------------------------------
#Vergi grafiði
# Veri
demand <- function(Q) 20 - 0.5 * Q
supply <- function(Q) 2 + 0.25 * Q
supply_tax <- function(Q) supply(Q) + 5

# Grafik
tax_graph(demand, supply, supply_tax, NULL)

# Alanlarý boyalý bir þekilde vergi grafiði
tax_graph(demand, supply, supply_tax, shaded = TRUE)

#-----------------------------------------------------------------------------------------------
#Laffer Eðrisi

laffer(ylab = "T", xlab = "t", # X ve Y ekseni baþlýklarý
       acol = "lightblue", # Alan rengi
       pointcol = 4)       # Maksimum noktadaki renk


# Grafiði biraz daha modifiye edelim
laffer(xmax = 20, #Maksimum nokta deðeri 
       t = c(3, 6, 9), # Kesiþimler
       generic = FALSE, # Jenerik etiketler olmasýn
       ylab = "T", # Y ekseni baþlýðý
       xlab = "t", # X ekseni baþlýðý
       acol = "lightblue", # Alan rengi
       alpha = 0.6,        # Alanýn transparanlýðý 
       pointcol = 4)       # Maksimum noktanýn rengi

#-------------------------------------------------------------------------------------------------
#Kesiþimler
# Ampirik verili Bézier eðrisi

# Eðriler
curve1 <- data.frame(Hmisc::bezier(c(1, 8, 9), c(1, 5, 9)))
curve2 <- data.frame(Hmisc::bezier(c(1, 3, 9), c(9, 3, 1)))

# Kesiþimleri hesapla
curve_intersection <- curve_intersect(curve1, curve2)

# ggplot2 yardýmý ile grafiði oluþtur
ggplot2::ggplot(mapping = ggplot2::aes(x = x, y = y)) +
  ggplot2::geom_line(data = curve1, color = "red", size = 1) +
  ggplot2::geom_line(data = curve2, color = "blue", size = 1) +
  ggplot2::geom_vline(xintercept = curve_intersection$x, linetype = "dotted") +
  ggplot2::geom_hline(yintercept = curve_intersection$y, linetype = "dotted") +
  ggplot2::theme_classic()


#----------------------------------

# Eðrileri fonksiyonlarla belirleyelim
curve1 <- function(q) (q - 10)^2
curve2 <- function(q) q^2 + 2*q + 8

# X ekseni aralýðý
x_range <- 0:5

# Ýki eðri arasýndaki kesiþimleri hesaplayalým
curve_intersection <- curve_intersect(curve1, curve2, empirical = FALSE, 
                                      domain = c(min(x_range), max(x_range)))

# ggplot2 yardýmýyla grafiðimizi oluþturalým
ggplot2::ggplot(data.frame(x = x_range)) +
  ggplot2::stat_function(ggplot2::aes(x = x), color = "blue", size = 1, fun = curve1) +
  ggplot2::stat_function(ggplot2::aes(x = x), color = "red", size = 1, fun = curve2) +
  ggplot2::geom_vline(xintercept = curve_intersection$x, linetype = "dotted") +
  ggplot2::geom_hline(yintercept = curve_intersection$y, linetype = "dotted") +
  ggplot2::theme_classic()