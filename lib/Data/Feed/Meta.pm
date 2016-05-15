package Data::Feed::Meta;

use Moose;
use Carp qw/carp croak/;

our $VERSION = '0.01';

has 'tags' => (
    traits => ['Hash'],
    is  => 'rw',
    lazy => 1,
    default => sub { { } },
    handles => {
       all    => 'elements',
       keys   => 'keys',
       fields => 'get',
       edit   => 'set',
    },
);

has 'card' => (
    is => 'ro',
    lazy => 1,
    default => sub { return shift->tags->{'card'} }
);

has 'site' => (
    is => 'ro',
    lazy => 1,
    default => sub { return shift->tags->{'site'} }
);

has 'title' => (
    is => 'ro',
    lazy => 1,
    default => sub { return shift->tags->{'title'} }
);

has 'description' => (
    is => 'ro',
    lazy => 1,
    default => sub { return shift->tags->{'description'} }
);

has 'image' => (
    is => 'ro',
    lazy => 1,
    default => sub { return shift->tags->{'image'} }
);

has 'link' => (
    is => 'ro',
    lazy => 1,
    default => sub { return shift->tags->{'link'} }
);

has 'site_name' => (
    is => 'ro',
    lazy => 1,
    default => sub { return shift->tags->{'site_name'} }
);

has 'parsed' => (
    is => 'rw',
    isa => 'Bool',
    lazy => 1,
    default => sub {
        return 1 if shift->title;
    },
);

sub parse {
    my ($self, $html) = @_;

    # can defiently do something better here but what i'm unsure other than use a module 
    # could also be one regex but splitting makes it easier to understand
    $$html =~ s/\>/\>\n/g;
    $$html =~ s/}/}\n/g;
    # lets do it a dummy way then utilise
    my @lines = split /\n/, $$html;
    my %fields;   
    foreach my $line ( @lines ) {
        my ($type, $field, $content);

        last if $line =~ m{</head>};
        next unless $line =~ m{<meta}xms;
        while ($line =~ /(?:^|\s+)(\S+)\s*=\s*("[^"]*"|\S*)/g) {
            # $1 - name, content or property
            my $att = $1;
            # $2 - value either twitter:field, og:field or content value
            my $cont = $2;

            next if $cont =~ m{sailthru};

            if ($att =~ /name|property/) { 
                ($type, $field) = split(/:/, $cont);
                next if !$field;
                $field =~ s/"|'//g;
            } elsif ( $att =~ /content/) {
                $content = $cont;
                $content =~ s/"|'//g;
            };
        }

        next unless $field and $content;
        # little bit of dirt, but it makes things easier for me should truncate i think
        $field = 'link' if $field eq 'url';
        if ($fields{$field}) {
            next unless $type =~ m{og|twitter};
            # some more dirt - blame PHP developers ;)
            my $more = length $content > length $fields{$field};
            $fields{$field} = $content if $more;
        } else {
            $fields{$field} = $content;
        }
    } 
  
    if (($fields{title} && $fields{'title'} =~ m{\w}) and ($fields{'description'} && $fields{'description'} =~ m{\w})){
        $self->tags(\%fields);
    } else {
        carp "The content returned is deemed unsuitable for meta parsing";
    }   
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
