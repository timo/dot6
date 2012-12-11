use Test;
use Graphviz::Dot;

plan 7;

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
