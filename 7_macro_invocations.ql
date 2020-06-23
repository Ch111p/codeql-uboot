import cpp

from MacroAccess ma
where ma.getMacroName().regexpMatch("ntoh\\w*")
select ma, "purpose macro access"