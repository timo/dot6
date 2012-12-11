use Test;
use Graphviz::Grammar;
use Graphviz::Dot;

plan 1;

{
    my $a = Graph.new: :items([Edge.new(Node.new("A"), Node.new("B"))]);
    lives_ok { Graphviz::Grammar::Dot.parse($a.dot) }, "parse a generated dot document";
}
