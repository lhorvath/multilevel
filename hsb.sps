* Encoding: UTF-8.
PRESERVE.
SET DECIMAL DOT.

GET DATA  /TYPE=TXT
  /FILE="C:\Users\lh459\Dropbox (CEMAP)\teaching\workshops\multilevel\multilevel-york-spss\hsb.csv"
  /ENCODING='Locale'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  schid AUTO
  minority AUTO
  female AUTO
  ses AUTO
  mathach AUTO
  size AUTO
  schtype AUTO
  meanses AUTO
  /MAP.
RESTORE.

CACHE.
EXECUTE.
DATASET NAME hsb.

DATASET ACTIVATE hsb.

* minority effect 1

t-test groups=minority(0 1)
  /variables=mathach.

* minority effect 2

glm mathach by minority schtype with ses 
  /print parameter
  /design=minority schtype ses.

* minority effect 3

mixed mathach by minority schtype with ses
 /fixed = minority ses schtype
 /random intercept | subject(schid)
 /print = solution.

* minority effect 4

mixed mathach by minority with ses
 /fixed = ses
 /random intercept minority | subject(schtype) covtype(un)
 /random intercept | subject(schid)
 /print = solution testcov.


mixed mathach by minority with ses
 /fixed = ses
 /random intercept minority | subject(schtype) covtype(un)
 /random intercept | subject(schid)
 /print = solution testcov.

* minority effect 5

mixed mathach by minority schtype with ses
 /fixed = ses minority*schtype
 /random intercept minority | subject(schtype) covtype(un)
 /random intercept | subject(schid)
 /print = solution testcov.






