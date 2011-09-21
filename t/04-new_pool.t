use Test::More 'no_plan';

use Object::Pool;

use Data::Dumper;

diag( "new() and general use case of Object::Pool $Object::Pool::VERSION" );

can_ok( 'Object::Pool', 'new' );

my $new_pool;
# should fail

eval {
    $new_pool = Object::Pool->new( 'mercy' );

};

warn Dumper( $new_pool );

isa_ok( $new_pool, 'Object::Pool' );
