import cpp

from Macro m
where m.getName().regexpMatch("nto\\w*")
select m, "purpose macros"