#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Object::Pool' ) || print "Bail out!\n";
}

diag( "Testing Object::Pool $Object::Pool::VERSION, Perl $], $^X" );
