(TeX-add-style-hook
 "bibunits-biblatex"
 (lambda ()
   (TeX-add-symbols
    '("putbib" ["argument"] 0))
   (LaTeX-add-labels
    "endtitle"))
 :latex)

