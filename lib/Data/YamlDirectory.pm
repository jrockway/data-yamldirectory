package Data::YamlDirectory;
use Moose;
use Carp;
use Scalar::Util qw(reftype);
use YAML::Syck qw(DumpFile LoadFile);
use MooseX::Types::Path::Class qw(Dir);
use Path::Class qw(file);

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

1;
__END__

=head1 NAME

Data::YamlDirectory - store key => { hash } pairs on disk as a directory of YAML files

=cut
