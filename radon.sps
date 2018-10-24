* Encoding: UTF-8.
PRESERVE.
SET DECIMAL DOT.

GET DATA  /TYPE=TXT
  /FILE="C:\Users\lh459\Dropbox (CEMAP)"+
    "\teaching\workshops\multilevel\multilevel-york-spss\radon.csv"
  /ENCODING='UTF8'
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  id AUTO
  cnt AUTO
  radon AUTO
  floor AUTO
  sample.size AUTO
  jitter AUTO
  uranium AUTO
  /MAP.
RESTORE.
CACHE.
EXECUTE.
DATASET NAME Radon.

DATASET ACTIVATE Radon.

* no pooling

CTABLES
  /VLABELS VARIABLES=cnt radon DISPLAY=LABEL
  /TABLE cnt [C] BY radon [S][MEAN, SEMEAN 'SE']
  /CATEGORIES VARIABLES=cnt ORDER=A KEY=VALUE EMPTY=EXCLUDE.

* with predictors : 85 regressions

regression 
  /select=cnt eq 'AITKIN'
  /dependent=radon
  /method=enter floor.

regression 
  /select=cnt eq 'ANOKA'
  /dependent=radon
  /method=enter floor.

* complete pooling

glm radon by cnt with floor.

* partial pooling

mixed radon
 /random intercept | subject(cnt)
 /print = solution.

* partial pooling with predictors

mixed radon with floor
 /fixed = floor
 /random intercept | subject(cnt)
 /print = solution.



