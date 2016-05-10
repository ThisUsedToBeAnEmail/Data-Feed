package Data::Feed;

use Mouse;
use Carp qw(croak);
use Data::Feed::Parser;
use Data::Feed::Stream;
use Data::Feed::Object;
use Data::Dumper;
use 5.006;

our $VERSION = '0.01';

has 'stream' => (
    is   => 'rw',
    lazy => 1,
    default => q{},
);

has 'fetch_stream' => (
    is   => 'ro',
    lazy => 1,
    default => sub { 
        return Data::Feed::Stream->new(stream => shift->stream) 
    }
);

has 'parser' => (
    is   => 'ro',
    lazy => 1,
    default => sub { 
        return Data::Feed::Parser->new(stream => shift->fetch_stream->open_stream) 
    }
);

has 'feed' => (
    is  =>  'rw',
    isa => 'ArrayRef[Data::Feed::Object]',
    traits  => ['Array'],
    default => sub { [ ] },
    handles => {
        all     => 'elements',
        count   => 'count',
        get     => 'get',
        delete  => 'delete',
    }
);

sub parse {
    my ($self, $stream) = @_;

    if (!$stream) {
        croak "No stream was provided to parse().";
    }
    
    $self->stream($stream);
   
    my $parser = $self->parser->parse;
    $self->feed($parser->parse);

    return 1;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Data::Feed

=head1 VERSION

Version 0.5

=head1 SYNOPSIS GOALS

    use Data::Feed;

    my $feed = Data::Feed->new();
    $feed->parse( '***' );

    $feed->all;
    $feed->count;
    $feed->delete();
    $feed->get();

    foreach my $entry ( $feed->all ) {
        $entry->plain_text;
        $entry->title->raw;
        $entry->title->plain_text;
    }

=head1 TODOs can be found in my broken tests

    02-feed.t
    03-object.t
    04-field.t

=head1 DESCRIPTION

Data::Feed is a frontend for feeds. It will attempt to guess what type of feed you are passing in, from this it will generate the appropriate feed object.

=over

=head1 Methods

=head2 parse

Populates the feed Attribute, this is an Array of Data::Feed::Object 's

You can pass this module a stream in the following formats

=item URI

    $feed->parse( 'http://examples.com/feed.xml' );

=item File

    $feed->parse( 'path/to/feed.xml' );

=item Raw XML

    $feed->parse( 'qq{<?xml version="1.0"><feed> .... </feed>} );

=head2 all

returns all elements in feed

=head2 count

returns the count of the current data feed

=head2 get

accepts an integer and returns an element of the feed by its Array index

=head2 delete

accepts an integer and deletes the relevant elemant based on its Array index

=over

=head1 AUTHOR


=head1 BUGS

Please report any bugs or feature requests to C<bug-data-feed at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Data-Feed>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.


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
