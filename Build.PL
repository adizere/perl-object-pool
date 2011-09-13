use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Object::Pool',
    license             => 'perl',
    dist_author         => q{Seredinschi Dragos-Adrian <adizere@gmail.com>},
    dist_version_from   => 'lib/Object/Pool.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'perl' => 5.006,
    },
    add_to_cleanup      => [ 'Object-Pool-*' ],
);

$builder->create_build_script();
