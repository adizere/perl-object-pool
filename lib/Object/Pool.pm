package Object::Pool;

use 5.006;
use strict;
use warnings;

use vars qw( $VERSION $LOW_WATERMARK $HIGH_WATERMARK );

use Carp;
use Data::Dumper;

our $VERSION = '0.01';

our $LOW_WATERMARK = 3;
our $HIGH_WATERMARK = 6;
our $SPARE_WATERMARK = undef; # don't use


sub new {
    my $class = shift();

    croak "Object::Pool constructor needs an Object::PoolFactory"
        unless( $_[0] && $_[0]->isa( 'Object::PoolFactory' ) );

    bless my $self = {}, $class;

    return $self;
}

1; # End of Object::Pool

__END__

=head1 NAME

Object::Pool - Pool of Generic Objects


=head1 VERSION

Version 0.01


=head1 SYNOPSIS

This class implements the pool itself, it can hold and manage a certain number
of objects belonging to any class that properly inherit from the
L<Object::Pool::Element> class.

Essentially, an Object pool pattern implementation is tried here.

The pool relies on a factory that knows how to create new objects that will be
inserted in the pool, usually an object of type L<Object::PoolFactory>.

A factory has to know what will be the type of objects it will instantiate.
In the simplest case, the factory receives the object type as a string, and it
will create objects by simply calling B<new> on that class.


=head1 EXPORT

Nothing is exported.
An OOP direction as pure as possible is intended.


=head1 CLASS CONSTANTS

=head2 $Object::Pool::LOW_WATERMARK

B<Default Value:>

3

B<Description:>

Specifies the lowest number of objects present in the pool, at any moment.
Used when the pool is initialized, in C<create_initial_pool()>.
To adjust this value, for example to 6, just:

    $Object::Pool::LOW_WATERMARK = 6;


=head2 $Object::Pool::HIGH_WATERMARK

B<Default Value:>

6

B<Description:>

Specifies the highest number of objects that will reside in the pool, at any
moment, regardless of their state. Modification of this value can be done in
the same manner as for $LOW_WATERMARK.


=head2 $Object::Pool::SPARE_WATERMARK

B<Not used, YET. Kinda useless in a non-threaded environment>
B<Description / Intention:>

If no more objects from the pool are free and the pool hasn't reached
$HIGH_WATERMARK, then $SPARE_WATERMARK objects would be created, such that
when a new object is requested, no overhead for creating it is encountered.
Ideally, the spare objects have to be created in a separate thread. But the Perl
threads are... not really threads.


##############
=head1 METHODS

=head2 new

    my $obj_pool = Object::Pool->new( FACTORY );

B<Description:>

    Creates a new object of this type.

B<Arguments:>

Need as argument a factory that creates objects held in the pool. The factory
could be of type Object::PoolFactory, or any other, as long as a method called
C<new_element()> is provided by that object.

B<Returns:>

A new Object::Pool object.


=head2 add

    $object_pool->add( OBJECT );

B<Description:>

Adds another resource object to the pool. Should only be used internally by
this class, a normal user needn't concern with this method.

B<Arguments:>

The object to be added, with the type - a subclass of the
B<Object::Pool::Element> class.

B<Returns:>

- the pool, on success;
- undef, on error;


=head2 create_initial_pool

    $object_pool->create_initial_pool();

B<Description:>

This method initializez the pool of objects that will be available for
retrieving (through C<retrieve()>).
Usually should be called only once, when a new instance of this class gets
created. But one other usage of this method is when C<reset_pool()> is called.

If the pool of objects already exists, then this method will have no effect.

B<Arguments:>

None.

B<Returns:>

The calling object.


=head2 retrieve

    my $free_element = $object_pool->retrieve();
    unless ( $free_element ) {
        print "All elements from the pool are busy, try later?";
    }
    print "The element returned is now in the state BUSY";
    # ...

B<Description:>

Gets from the pool of objects a single element that is in the 'Free' or 'New'
state. Updates the object state to 'Busy' and returns it.

Usually, an object in state 'Free' should have identical properties as when it
was in the state 'New'. A somewhat I<pure> state (see the C<purify()> method),
but a distinction between them exists so this module is easily extensible and
applicable.


B<Arguments:>

None.

B<Returns:>

A free/new element from the pool if any was found, and undef if none was found.


=head2 fetch

    my $free_element = $object_pool->fetch();
    unless ( $free_element ) {
        print "All elements from the pool are busy, try later?";
    }
    print "The returned element is in the state FREE or in the state NEW";
    # ...

B<Description:>

Gets from the pool of objects one element that is in the 'Free' or 'New'
state and returns it.

In the first versions of this module, this method simply searches linearly
and retrieves the first free/new element that was found. A LoadBalancer is
on the TODO list and will be added later.

B<Arguments:>

None.

B<Returns:>

An element in the 'FREE' or 'NEW' state.


=head2 release

    my $element = $object_pool->retrieve();
    unless ( $element ) {
        print "All elements from the pool are busy, try later?";
    }
    print "The element returned is now in the state BUSY";
    # ...
    $object_pool->release( $element );
    print "The element is now in the state FREE";

B<Description:>

Changes the state of the supplied element to FREE. This will have as a side
effect the calling of C<purify> on that element.

This method can be regarded as the opposite of C<retrieve()>.

B<Arguments:>

An element from the pool that was previously retrieve()-ed, which should be in
the BUSY state.

B<Returns:>

The pool on which the method was called.
Undef on errors.


=head2 reset_pool

    $pool->reset_pool();

B<Description:>

Release all of the objects present in the pool (effectively put them in the
'Evicted' state) - all references to the pool elements are deleted, and then the
pool is recreated, new instances are added and everything is left in the 'New'
state.

B<Arguments:>

None.

B<Returns:>

The pool.

=cut


#############
=head1 AUTHOR

Seredinschi Dragos-Adrian, C<< <adizere at gmail.com> >>


=head1 BUGS / SUGGESTIONS

If you found any bugs and want to help, or have any suggestions to make, email
me.


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
