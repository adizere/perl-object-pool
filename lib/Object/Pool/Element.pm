package Object::Pool::Element;

use 5.006;
use strict;
use warnings;






1; # End of Object::Pool::Element

__END__

=head1 NAME

Object::Element - Basic element that defines the interface for working with an
Object::Pool.


=head1 SYNOPSIS

    # ...
    my $element = $pool->retrieve();
    
    # use $element
    $pool->release( $element );

This class defines the default behaviour for the elements held in an
Object::Pool. In a normal usage scenario, you would subclass and overide
the needed method of this class.


=head1 EXPORT

Nothing.
OOP usage.


=head1 METHODS

=head2 new


B<Description:>



B<Arguments:>



B<Returns:>




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