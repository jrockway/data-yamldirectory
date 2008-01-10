use strict;
use warnings;
use Directory::Scratch;
use Data::YamlDirectory;
use Test::More;
use YAML::Syck qw(LoadFile);

my $tmp = Directory::Scratch->new;
my $ydir = Data::YamlDirectory->new(directory => "$tmp");

my %structs = (
    foo => { 
        foo => 'bar',
        bar => 'foo',
    },
    bar => {
        bar => 'bar',
    },
    array => {
        array => [1..10],
    },
);

plan tests => 2 * scalar keys %structs;

for my $key (keys %structs){
    $ydir->store( $key => $structs{$key} );
}

ok $tmp->exists($_) for keys %structs;
is_deeply LoadFile($tmp->exists($_)), $structs{$_} for keys %structs;

