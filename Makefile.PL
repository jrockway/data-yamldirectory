use inc::Module::Install;

name 'Data-YamlDirectory';
all_from 'lib/Data/YamlDirectory.pm';

build_requires 'Catalyst::Runtime';
build_requires 'Test::WWW::Mechanize::Catalyst';
build_requires 'Test::More';
build_requires 'ok';

WriteAll();
