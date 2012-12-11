use Test;
use Graphviz::Grammar;

plan 1;

lives_ok { Graphviz::Grammar::Dot.parse(q[
    graph {
        A
        B;
        C -- A;
    }
]) }, "parse a simple example";
