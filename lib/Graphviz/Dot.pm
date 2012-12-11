use v6;

module Graphviz::Dot;

our class Node is export {
    has $.name;
    has %.attribute;

    method dot(--> Str) {
        "$.name"
    }

    method new($name) {
        self.bless(*, :$name);
    }
}

our class Edge is export {
    has Node $.from;
    has Node $.to;
    has %.attribute;

    method dot(--> Str) {
        "$.from.dot() -> $.to.dot()"
    }
}

our class Subgraph is export {
    has Node @.node;
    has Edge @.edge;
    has %.attribute;
}

our class Graph is export {
    has Str $.name = '';
    has Node %.node;
    has Edge @.edge;
    has Subgraph @.subgraphs;
    has Bool $!is_digraph = False;
    has Int $!anon_ctr;

    multi method push(@things) {
        self.push: $_ for @things;
    }

    multi method push(Node $node) {
        %.node{$node.name} = $node
    }

    multi method push(Edge $edge) {
        push @.edge, $edge;
        self.push($edge.from);
        self.push($edge.to);
    }

    multi method push(Subgraph $sg, :$direct) {
        push @.subgraphs, $sg if !$direct;
        self.push: $_ for $sg.node.value;
        self.push: $_ for $sg.edge;
        self.push: $sg.subgraphs, :!direct;
    }

    method new(:@items) {
        self.bless(*, :@items);
    }

    submethod BUILD(:@items) {
        self.push: @items;
    }

    method dot(--> Str) {
        my Str $r = "graph $.name \{\n";
        $r ~= ("    " ~ $_.dot for %.node.values).join("\n");
        $r ~= ("    " ~ $_.dot for @.edge).join("\n");
        $r ~= "\n}"
    }
}
