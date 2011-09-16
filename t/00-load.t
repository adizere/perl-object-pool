use Test::More tests => 8;

BEGIN {

    my @class_names = (
        'Object::Pool',
        'Object::PoolFactory',
        'Object::Pool::Element',
        'Object::Pool::Element::State',
        'Object::Pool::Element::State::Busy',
        'Object::Pool::Element::State::Free',
        'Object::Pool::Element::State::New',
        'Object::Pool::Element::State::Evicted'
    );

    foreach( @class_names ) { 
        use_ok( $_ ) || print "Bailing out at $_ !\n";
    }
}

diag( "Testing Object::Pool $Object::Pool::VERSION classes, Perl $], $^X" );