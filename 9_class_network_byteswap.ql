import cpp

class NetWorkByteSwap extends Expr {
    NetWorkByteSwap () {
        exists(MacroInvocation mi |
            this = mi.getExpr() and
            mi.getMacroName().regexpMatch("ntoh\\w*")
        )
    }
}

from NetWorkByteSwap n
select n, "Network byte swap"