﻿* Encoding: UTF-8.

* An example of the syntax that is generated by the Benford's Law Extension.

COMPUTE FirstDigit=NUMBER(CHAR.SUBSTR(LTRIM(STRING(length ,F20)),1,1),F20.0). 
COMPUTE Benford=LG10(1+(1/FirstDigit))*100. 
variable labels firstdigit "First Digit of length".
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=FirstDigit COUNT()[name="COUNT"] 
    MEAN(Benford)[name="MEAN_Benford"] MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: FirstDigit=col(source(s), name("FirstDigit"), unit.category())
  DATA: COUNT=col(source(s), name("COUNT"))
  DATA: MEAN_Benford=col(source(s), name("MEAN_Benford"))
  GUIDE: axis(dim(1), label("FirstDigit"))
  GUIDE: axis(scale(y1), label("Count"), color(color."3E58AC"))
  GUIDE: axis(scale(y2), label("Mean Benford"), color(color."2EB848"), opposite())
  GUIDE: text.title(label("Benford's Law breakdown of length "))
  SCALE: y1 = linear(dim(2), include(0))
  SCALE: y2 = linear(dim(2), include(0))
  ELEMENT: interval(position(FirstDigit*COUNT), shape.interior(shape.square), 
    color.interior(color."3E58AC"), scale(y1))
  ELEMENT: line(position(FirstDigit*MEAN_Benford), missing.wings(), color.interior(color."2EB848"),     
    scale(y2))
END GPL.
FREQUENCIES VARIABLES=FirstDigit.
DELETE VARIABLES FirstDigit, Benford.
