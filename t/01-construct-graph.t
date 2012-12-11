use Test;
use Graphviz::Dot;

plan 11;

lives_ok { my $a = Graph.new }, "new empty graph";
lives_ok { my $a = Graph.new: :items([Node.new("A"), Node.new("B")]) }, "new non-empty graph";

{
    my $a = Graph.new: :items([Node.new("A")]);
    is +$a.node, 1, "nodes from constructor get added";
    $a.push: Node.new("B");
    is +$a.node, 2, "nodes with push get added, too";
    $a.push: [Node.new("C"), Node.new("D")];
    is +$a.node, 4, "array push works";
    $a.push: Node.new("B");
    is +$a.node, 4, "duplicate node names get normalised";
    my Str $rendered = $a.dot;
    ok $rendered ~~ /A/ & /B/ & /C/ & /D/, "all nodes are represented in the output";
}
{
    my $a = Graph.new: :items([Edge.new(Node.new("A"), Node.new("B"))]);
    is +$a.edge, 1, "edges get added from the constructor";
    is +$a.node, 2, "nodes from edges get collected";
    $a.push: [Edge.new(Node.new("B"), Node.new("C"))];
    is +$a.edge, 2, "edges can be pushed";
    is +$a.node, 3, "nodes from edges get re-used";
}
