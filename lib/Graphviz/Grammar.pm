use v6;

module Graphviz::Grammar;

grammar Dot {
    rule graph {
        ["graph" | "digraph"] <id>? '{'
            <stmt_list>
        '}'
    }
    rule stmt_list {
        <stmt> ';'? <stmt_list>?
    }
    rule stmt {
        <node_stmt> | <edge_stmt>
    }
    rule node_stmt {
        <id>
    }
    rule edge_stmt {
        <id> <edgeRHS>
    }
    rule edgeRHS {
        <edgeop> <id> <edgeRHS>
    }
    regex id {
        <[_ a..z A..Z]>(<[_ a..z A..Z 0..9]>*)
    }
    token edgeop {
        '--' | '->' | '<-'
    }

    rule TOP {
        <graph>
    }
}

# vi: set ft=perl6
