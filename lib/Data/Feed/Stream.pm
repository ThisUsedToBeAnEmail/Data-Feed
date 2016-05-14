package Data::Feed::Stream;

use Moose;
use Carp qw/croak/;
use Data::Dumper;
use Path::Class;
use LWP::UserAgent;
use HTTP::Request;
use autodie;

our $VERSION = '0.01';

has 'stream' => (
    is  => 'rw',
    isa => 'Str',
    lazy => 1,
    default => q{}
);

has 'stream_type' => (
    is      => 'ro',
    isa     => 'Str',
    default => sub {
        my $self = shift;
        return 'url' if $self->stream =~ m{^http}xms;
        return 'string' if $self->stream =~ m{\<\?xml}xms;
        return 'file' if $self->stream =~ m{(\.xml|\.html)}xms; 
    }
);

sub open_stream {
    my $self = shift;
    my $type = 'open_' . $self->stream_type;
    return $self->$type;
}

sub open_url {
    my ($self) = shift;

    my $stream = $self->stream;
    my $ua = LWP::UserAgent->new();
    $ua->env_proxy;

    my $req = HTTP::Request->new( GET => $stream );
    $req->header( 'Accept-Encoding', 'gzip' );

    my $res = $ua->request($req) or croak "Failed to fetch URI: $stream";

    if ( $res->code == 410 ) {
        croak "This feed has been permantly removed";
    }

    my $content = $res->decoded_content(charset => 'none');

    return \$content;
}

sub open_file {
    my ($self) = shift;

    my $stream = $self->stream;

    open ( my $fh, '<', $stream ) or croak "could not open file: $stream";

    my $content = do { local $/; <$fh> };
    close $fh;

    return \$content;
}

sub open_string { return shift->stream; }

sub write_file {
    my ($self, $feed) = @_;

    my $stream = $self->stream;

    open FILE, ">", $stream  or croak "could not open file: $stream";
    print FILE $feed;
    close FILE;
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
