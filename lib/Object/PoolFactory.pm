package Object::PoolFactory;

use 5.006;
use strict;
use warnings;






1; # End of Object::PoolFactory

__END__

=head1 NAME

Object::PoolFactory - Factory for the pool of objects.


=head1 SYNOPSIS

The factory lies between the Pool and the Objects the pool manages. Has the role
of detaching some responsibility from the pool side. The object creation
phase (even if low in complexity) will be handled in the PoolFactory, and the
Pool only has to be aware of the fact that it's factory provides the
C<new_element()> method.

A simple diagram:

|---------|                   |-------------|               |-----------|
|         |     <<call>>      |             |  <<create>>   |           |
|  Pool   |------------------>| PoolFactory |-------------->|   Pool    |
|         |   new_element()   |             |               |  Element  |
|---------|                   |-------------|               |           |
                                                            |-----------|
The <<create>> here stands for any method of instantiating a class, through
C<new()>, a specific Builder, etc..


=head1 EXPORT

Nothing.
OOP usage.


=head1 METHODS

=head2 new

    my $factory = Object::PoolFactory->new( OBJECT_TYPE );
    
    
    # I<Object::Pool::Element::MyElement> class exists, inheriting from
    # I<Object::Pool::Element>
    my $factory = Object::PoolFactory->new( 'Object::Pool::Element::MyElement' );

B<Description:>

    Creates a new instance of this class.

B<Arguments:>

This method takes as argument the name of the I<Object::Pool::Element::*> to
instantiate through C<new()>. It was thinked for usage together with
subclasses of I<Object::Pool::Element>.

B<Returns:>

A new Object::PoolFactory object.


=head2 new_element

    my $pool_object_factory = Object::PoolFactory->new( 'Object::Pool::Element::MyElement' );
    my $pool_element = $pool_object_factory->new_element();

B<Description:>

A uniform method of providing a Pool with the objects it will hold. Every Pool
will have a single object that will be used as the factory, and that factory has
to provide this method.

B<Arguments:>

None.

B<Returns:>

A new element that a Pool can use.


=head1 AUTHOR

Seredinschi Dragos-Adrian, C<< <adizere at gmail.com> >>


=head1 BUGS / SUGGESTIONS

If you found any bugs and want to help, or have any suggestions to make, just
email me.


=head1 ACKNOWLEDGEMENTS

Made use of information from article "Pooling", by I<Michael Kircher, Prashant Jain>
that can be consulted at C<http://www.kircher-schwanninger.de/michael/publications/Pooling.pdf>.


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Seredinschi Dragos-Adrian.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut