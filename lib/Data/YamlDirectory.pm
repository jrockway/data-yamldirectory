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

=cut
