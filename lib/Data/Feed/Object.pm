package Data::Feed::Object;

use Moose;
use Carp qw/croak/;
use Data::Feed::Object::Title;
use Data::Feed::Object::Link;
use Data::Feed::Object::Description;
use Data::Feed::Object::PubDate;
use Data::Feed::Object::AsXml;

our $VERSION = '0.01';

has 'object' => (
    traits => ['Hash'],
    is  => 'ro',
    lazy => 1,
    default => sub { { } },
    handles => {
       keys   => 'keys',
       fields => 'get',
       edit   => 'set',
    },
);

has 'title' => (
    is => 'ro',
    lazy => 1,
    default => sub {
        return Data::Feed::Object::Title->new(raw => shift->object->{'title'});
    }
);

has 'link' => (
    is => 'ro',
    lazy => 1,
    default => sub {
        return Data::Feed::Object::Link->new(raw => shift->object->{'link'});
    }
);

has 'description' => (
    is => 'ro',
    lazy => 1,
    default => sub {
        return Data::Feed::Object::Description->new(raw => shift->object->{'description'});
    }
);

has 'pub_date' => (
    is => 'ro',
    lazy => 1,
    default => sub {
        return Data::Feed::Object::PubDate->new(raw => shift->object->{'pubDate'});
    }
);

has 'as_xml' => (
    is => 'ro',
    lazy => 1,
    default => sub {
        return Data::Feed::Object::AsXml->new(raw => shift->object->{'as_xml'});
    }
);

sub render {
    my ( $self, $format ) = @_;

    $format ||= 'text';
    my @render;
    foreach my $key ( $self->keys ) {
        my $field = $self->$key;
        my $type = 'as_' . $format;
        push @render, $field->$type;
    }
    
    return join "\n", @render;
}

sub hash {
    my ( $self, $format ) = @_;
   
    $format ||= 'text';

    my %object;
    for my $key ( keys $self->object ) {
        my $field = $self->$key;
        my $type = 'as_' . $format;
        $object{$key} = $self->$key->$type; 
    }
    return \%object;
}

__PACKAGE__->meta->make_immutable;

=head1 AUTHOR

LNATION, C<< <thisusedtobeanemail at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-data-feed at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Data-Feed>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Data::Feed


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Data-Feed>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Data-Feed>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Data-Feed>

=item * Search CPAN

L<http://search.cpan.org/dist/Data-Feed/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2016 LNATION.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Data::Feed
