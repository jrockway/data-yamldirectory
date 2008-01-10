package Data::YamlDirectory;
use Moose;
use Carp;
use Scalar::Util qw(reftype);
use YAML::Syck qw(DumpFile LoadFile);
use MooseX::Types::Path::Class qw(Dir);
use Path::Class qw(file);

our $VERSION = '0.01';

has 'directory' => (
    is       => 'ro',
    isa      => Dir,
    required => 1,
    coerce   => 1,
);

sub fetch {
    my ($self, $key) = @_;
    my $filename = file($self->directory, $key);
    return undef unless -f $filename;
    my $data = LoadFile($filename);
    croak "Data loaded from `$filename' is not a HASH"
      unless reftype $data eq 'HASH';
    return $data;
}

sub store {
    my ($self, $key, $data) = @_;
    croak 'Attempting to store non-HASH data'
      unless reftype $data eq 'HASH';
    
    my $filename = file($self->directory, $key);
    DumpFile($filename, $data);
    return;
}

1;
__END__

=head1 NAME

Data::YamlDirectory - store key => { hash } pairs on disk as a directory of YAML files

=head1 SYNOPSIS

  my $ydr = Data::YamlDirectory(directory => '/foo/bar');
  $ydr->store('foo', { this => [qw/is a hash/] });
  ...
  $ydr->fetch('foo'); # { this => [qw/is a hash] }
  

=head1 DESCRIPTION

This module is a quick-n-easy way of storing human-understandable key
=> value pairs to disk.  This code is factored out of
L<Angerwhale|Angerwhale>, where it's used to store user data to disk
in a format that's easy for the blog administrator to edit if the need
arises.

=head1 METHODS

=head2 store(key, { hash })

Stores C<hash> as C<key>.  Croaks if there is a write error or if
C<hash> isn't a hash reference.

=head2 fetch(key)

Retrives the hash associated with C<key>.  Returns undef (even in list
context) if the key is not on disk.  Dies if the file is unreadable,
there is a YAML parse error, or the deserialized structure isn't a
hash.

=head1 AUTHOR

Jonathan Rockway

=head1 COPYRIGHT

Copyright (c) 2008 Infinity Interactive, Inc.

This module is Free Software, you may redistribute it under the same
terms as Perl itself.
