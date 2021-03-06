#econocharts

#Paketi indirme
install.packages("devtools") #�ndirilmemi�se indirebilirsiniz
devtools::install_github("R-CoderDotCom/econocharts") #econocharts paketini indirelim

#Paketi �a��ral�m
library(econocharts)


#Arz grafi�i
supply() # Varsay�lan grafik


supply(ncurves = 1,           # Ka� arz e�risi �izilmesi gerekiyor?
       type = "line",         # E�ri tipi
       x = c(2, 4, 5),        # Kesi�imleri olu�turmak i�in y-ekseni de�erleri
       linecol = 2,           # E�rilerin rengi
       geom = "label",        # Kesi�im noktalar�n�n etiket tipi
       geomfill = "pink",     # E�er geom = "label" arg�man� girilmi�se, etiketin arka plan rengi
       main = "Supply curve") # Grafik ba�l���


supply(ncurves = 3, # 3 arz e�risi olsun
       xlab = "X",  # X ekseni ba�l���
       ylab = "Y",  # Y ekseni ba�l���
       bg.col = "lightblue") # Arkaplan rengi


#----------------------------------------------------------------------------------------------
#Talep grafi�i

demand(x = 3:6,  # Kesi�imler
       generic = FALSE) # Say� de�erleriyle eksen etikerleri


demand(main = "Demand", # Ba�l�k
       sub = "curve",   # Alt ba�l�k
       xlab = "X",      # X-ekseni etiketi
       ylab = "Y",      # Y-ekseni etiketi
       names = "D[1]",  # E�ri ba�l���
       geomcol = 2)     # E�ri ba�l���n�n rengi


#---------------------------------------------------------------------------------------------
#Arz ve talep grafi�i

sdcurve() #Varsay�lan grafik


# Kendi verimizi olu�tural�m
supply1 <- data.frame(x = c(1, 9), y = c(1, 9))
supply1

demand1 <- data.frame(x = c(7, 2), y = c(2, 7))
demand1

supply2 <- data.frame(x = c(2, 10), y = c(1, 9))
supply2

demand2 <- data.frame(x = c(8, 2), y = c(2, 8))
demand2

p <- sdcurve(supply1,   # Verilerimizi ilgili fonksiyona arg�man olarak giriyoruz
             demand1,
             supply2, 
             demand2,
             equilibrium = TRUE, # Dengeyi hesaplat�yoruz
             bg.col = "#fff3cd") # Arkaplan rengini belirleyelim
p + ggplot2::annotate("segment", x = 2.5, xend = 3, y = 6.5, yend = 7,                # Grafi�e ok ekleyelim
             arrow = grid::arrow(length = grid::unit(0.3, "lines")), colour = "grey50")


#----------------------------------------------------------------------------------------------

#Kay�ts�zl�k e�rileri

indifference() # Varsay�lan grafik


indifference(ncurves = 2,  # 2 e�ri olsun
             x = c(2, 4),  # Kesi�imler
             main = "Indifference curves", # Grafik ba�l���
             xlab = "Good X", # X ekseni ba�l���
             ylab = "Good Y", # Y ekseni ba�l���
             linecol = 2,  # E�ri renkleri
             pointcol = 2) # Kesi�im noktalar�n�n rengi

#-------------------------
p <- indifference(ncurves = 2, x = c(2, 4), main = "Indifference curves", xlab = "Good X", ylab = "Good Y") # Kay�ts�zl�k e�risi

int <- dplyr::bind_rows(curve_intersect(data.frame(x = 1:1000, y = rep(3, nrow(p$curve))), p$curve + 1)) # Kesi�imler

p$p + ggplot2::geom_segment(data = int, ggplot2::aes(x = 0, y = y, xend = x, yend = y), lty = "dotted")  + # Kesikli �izgilerin eklenmesi
  ggplot2::geom_segment(data = int, ggplot2::aes(x = x, y = 0, xend = x, yend = y), lty = "dotted") +
  ggplot2::geom_point(data = int, size = 3)
#-------------------------

indifference(ncurves = 2,    # �ki e�ri �izdir
             type = "pcom",  # M�kemmel tamamlay�c�
             main = "Indifference curves", # Grafik ba�l���
             sub = "Perfect complements", # Grafik alt ba�l���
             xlab = "Good X", # X ekseni ba�l���
             ylab = "Good Y", # Y ekseni ba�l���
             bg.col = "#fff3cd", # Arkaplan rengi
             linecol = 1)  # E�ri rengi
#---------------------------

indifference(ncurves = 5,     # 5 e�ri �izdir
             type = "psubs",  # M�kemmel tamamlay�c�lar
             main = "Indifference curves", #Grafik ba�l���
             sub = "Perfect substitutes", # Alt ba�l�k
             xlab = "Good X", # X ekseni ba�l���
             ylab = "Good Y", # Y ekseni ba�l���
             bg.col = "#fff3cd", # Arkaplan rengi
             linecol = 1) # E�ri rengi

#------------------------------------------------------------------------------------------------------
# �retim �mkanlar� E�risi (Production�possibility frontier)

ppf(x = 1:6, # Kesi�imler
    main = "PPF", # Grafik ba�l���
    geom = "text", # Eksenlerde text format�nda tikler olsun
    generic = TRUE, # Jenerik eksen etiketleri
    xlab = "X", # X ekseni ba�l���
    ylab = "Y", # Y ekseni ba�l���
    labels = 1:6, # Kesi�im noktalar� etiketleri
    acol = 3) # E�ri alt�ndaki alan rengi

#--------------------
p <- ppf(x = 4:6, # Kesi�imler
         main = "PPF", # Grafik ba�l���
         geom = "text", # Eksenlerde text format�nda tikler olsun
         generic = TRUE, # Jenerik etiketler
         labels = c("A", "B", "C"), # Etiketler
         xlab = "BIKES", # X ekseni ba�l���
         ylab = "CARS", # Y ekseni ba�l���
         acol = 3)      # Grafik alt�nda kalan alan

p$p + ggplot2::geom_point(data = data.frame(x = 5, y = 5), size = 3) + #ggplot2 yard�m� ile oklar�n eklenmesi
  ggplot2::geom_point(data = data.frame(x = 2, y = 2), size = 3) +
  ggplot2::annotate("segment", x = 3.1, xend = 4.25, y = 5, yend = 5,
           arrow = grid::arrow(length = grid::unit(0.5, "lines")), colour = 3, lwd = 1) +
  ggplot2::annotate("segment", x = 4.25, xend = 4.25, y = 5, yend = 4,
           arrow = grid::arrow(length = grid::unit(0.5, "lines")), colour = 3, lwd = 1)

#------------------------------------------------------------------------------------------------
#Vergi grafi�i
# Veri
demand <- function(Q) 20 - 0.5 * Q
supply <- function(Q) 2 + 0.25 * Q
supply_tax <- function(Q) supply(Q) + 5

# Grafik
tax_graph(demand, supply, supply_tax, NULL)

# Alanlar� boyal� bir �ekilde vergi grafi�i
tax_graph(demand, supply, supply_tax, shaded = TRUE)

#-----------------------------------------------------------------------------------------------
#Laffer E�risi

laffer(ylab = "T", xlab = "t", # X ve Y ekseni ba�l�klar�
       acol = "lightblue", # Alan rengi
       pointcol = 4)       # Maksimum noktadaki renk


# Grafi�i biraz daha modifiye edelim
laffer(xmax = 20, #Maksimum nokta de�eri 
       t = c(3, 6, 9), # Kesi�imler
       generic = FALSE, # Jenerik etiketler olmas�n
       ylab = "T", # Y ekseni ba�l���
       xlab = "t", # X ekseni ba�l���
       acol = "lightblue", # Alan rengi
       alpha = 0.6,        # Alan�n transparanl��� 
       pointcol = 4)       # Maksimum noktan�n rengi

#-------------------------------------------------------------------------------------------------
#Kesi�imler
# Ampirik verili B�zier e�risi

# E�riler
curve1 <- data.frame(Hmisc::bezier(c(1, 8, 9), c(1, 5, 9)))
curve2 <- data.frame(Hmisc::bezier(c(1, 3, 9), c(9, 3, 1)))

# Kesi�imleri hesapla
curve_intersection <- curve_intersect(curve1, curve2)

# ggplot2 yard�m� ile grafi�i olu�tur
ggplot2::ggplot(mapping = ggplot2::aes(x = x, y = y)) +
  ggplot2::geom_line(data = curve1, color = "red", size = 1) +
  ggplot2::geom_line(data = curve2, color = "blue", size = 1) +
  ggplot2::geom_vline(xintercept = curve_intersection$x, linetype = "dotted") +
  ggplot2::geom_hline(yintercept = curve_intersection$y, linetype = "dotted") +
  ggplot2::theme_classic()


#----------------------------------

# E�rileri fonksiyonlarla belirleyelim
curve1 <- function(q) (q - 10)^2
curve2 <- function(q) q^2 + 2*q + 8

# X ekseni aral���
x_range <- 0:5

# �ki e�ri aras�ndaki kesi�imleri hesaplayal�m
curve_intersection <- curve_intersect(curve1, curve2, empirical = FALSE, 
                                      domain = c(min(x_range), max(x_range)))

# ggplot2 yard�m�yla grafi�imizi olu�tural�m
ggplot2::ggplot(data.frame(x = x_range)) +
  ggplot2::stat_function(ggplot2::aes(x = x), color = "blue", size = 1, fun = curve1) +
  ggplot2::stat_function(ggplot2::aes(x = x), color = "red", size = 1, fun = curve2) +
  ggplot2::geom_vline(xintercept = curve_intersection$x, linetype = "dotted") +
  ggplot2::geom_hline(yintercept = curve_intersection$y, linetype = "dotted") +
  ggplot2::theme_classic()