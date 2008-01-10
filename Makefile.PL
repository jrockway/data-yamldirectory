use inc::Module::Install;

name 'Data-YamlDirectory';
all_from 'lib/Data/YamlDirectory.pm';

requires 'Moose';
requires 'MooseX::Types::Path::Class';
requires 'Path::Class';
requires 'Scalar::Util';
requires 'YAML::Syck';
build_requires 'Directory::Scratch';
build_requires 'Test::More';
build_requires 'ok';

WriteAll();
