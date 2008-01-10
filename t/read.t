use strict;
use warnings;
use Directory::Scratch;
use Data::YamlDirectory;
use Test::More tests => 1;

my $tmp = Directory::Scratch->new;
$tmp->touch('test', '---', 'foo: bar', 'bar: baz');

my $ydir = Data::YamlDirectory->new(directory => "$tmp");
my $hash = $ydir->fetch('test');

is_deeply $hash, { foo => 'bar', bar => 'baz' }, 'read YAML hash';


