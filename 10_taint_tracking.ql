import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetWorkByteSwap extends Expr {
    NetWorkByteSwap () {
        exists(MacroInvocation mi |
            this = mi.getExpr() and
            mi.getMacroName().regexpMatch("ntoh\\w*")
        )
    }
}

class Config extends TaintTracking::Configuration {
    Config() { this = "NetworkToMemFuncLength" }

    override predicate isSource(DataFlow::Node source) {
        source.asExpr() instanceof NetWorkByteSwap
    }

    override predicate isSink(DataFlow::Node sink) {
        exists (FunctionCall call | 
            call.getTarget().getName() = "memcpy" and 
            sink.asExpr() = call.getArgument(2)
        )
    }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows memcpy"