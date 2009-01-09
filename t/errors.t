use strict;
use warnings;
use Directory::Scratch;
use Data::YamlDirectory;
use Test::Exception;
use Test::More tests => 4;

my $tmp = Directory::Scratch->new;
my $ydr = Data::YamlDirectory->new(directory => "$tmp");

throws_ok {
    $ydr->store('foo/bar', { key => 'val' })
} qr/Cannot write to/;

throws_ok {
    $ydr->store('foo', [ key => 'value' ])
} qr/Attempting to store non-HASH/;

$tmp->touch('not_yaml', <<'HERE');
---
this: is
 not: yaml
HERE
throws_ok {
    $ydr->fetch('not_yaml');
} qr/syntax error/;

$tmp->touch('not_hash', <<'HERE');
---
- 1
- 2
- 3
HERE
throws_ok {
    $ydr->fetch('not_hash');
} qr/not a hash/i;

