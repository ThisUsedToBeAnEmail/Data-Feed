package Data::Feed;

use Moo;
use Carp qw(croak);
use LWP::UserAgent;
use Data::Feed::Parser::RSS;
use Data::Feed::Parser::Atom;
use 5.006;
use Data::Dumper;

our $VERSION = '0.01';

sub parse {
    my ($self, $stream) = @_;

    if (!$stream) {
        croak "No stream was provided to parse().";
    }
    
    my $content_ref = $self->fetch_stream($stream);

    my $parser = $self->find_parser( $content_ref );
    warn Dumper 'I make it here';
    return $parser->parse( $content_ref );
}

=head2 function2

=cut

sub fetch_stream {
    my ($self, $stream) = @_;

    my $content = '';
    my $ref = ref $stream || '';

    if ( $stream =~ m{^http}xms ){
        $content = $self->_url_stream($stream);
    }
    elsif ( $ref eq 'SCALAR' ) {
        $content = $$stream;
    }
    elsif ( $ref eq 'GLOB' ) {
        $content = do { local $/; <$stream> };
    }
    else {
        open ( my $fh, '<', $stream ) or croak "could not open file: $stream";
        
        $content = do { local $/; <$fh> };
        close $fh
    }

    return \$content;
}

sub find_parser {
    my ($self, $content_ref) = @_;

    my $format = $self->guess_format( $content_ref );

    croak "Unable to guess format from stream content" unless $format;

    my $class = 'Data::Feed::Parser::' . $format;

    return $class->new(content_ref => $content_ref);
}

sub guess_format {
    my ($self, $content_ref) = @_;
    
    my $tag;

    while ($$content_ref =~ /<(\S+)/sg) {
        (my $t = $1) =~ tr/a-zA-Z0-9:\-\?!//cd;
        my $first = substr $t, 0, 1;
        $tag = $t, last unless $first eq '?' || $first eq '!';
    }

    croak 'Coult not find the first XML element' unless $tag;

    $tag =~ s/^.*://;

    if ($tag =~ /^(?:rss|rdf)$/i) {
        return 'RSS';
    } elsif ($tag =~ /^feed/i) {
        return 'Atom';
    }

    return ();
}

sub _url_stream {
    my ($self, $stream) = @_;
    
    my $ua = LWP::UserAgent->new();
    $ua->env_proxy;
    my $req = HTTP::Request->new( GET => $stream );
    $req->header( 'Accept-Encoding', 'gzip' );
    my $res = $ua->request($req) or croak "Failed to fetch URI: $stream";
    
    if ( $res->code == 410 ) {
       croak "This feed has been permanently removed";
    }

    return $res->decoded_content(charset => 'none');

}


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
