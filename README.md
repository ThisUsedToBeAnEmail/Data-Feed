# NAME

Data::Feed

# VERSION

Version 0.5

# SYNOPSIS GOALS

    use Data::Feed;

    my $feed = Data::Feed->new();
    my $articles = $feed->parse( '***' );

    # a lot of to-do's
    $feed->count;
    $feed->all;
    $feed->return_range();
    $feed->search(article name);
    $feed->join( '***' );
    $feed->push( %hash ); 
    $feed->delete();

    print $feed->as_raw;
    print $feed->as_html;
    print $feed->as_xml;
    print $feed->as_plain;
    print $feed->as_meta;

    foreach my $art ( $feed->all ) {

        $art->as_raw;
        $art->as_plain;
        $art->as_xml;
        $art->as_html;
        $art->as_meta;

        $art->as_hash_raw;
        $art->as_hash_plain;
        $art->as_hash_xml;
        $art->as_hash_html;
        $art->as_hash_meta;

        $art->edit( %hash );
        $art->title->edit( );

        # each individual fields have the same methods missing some i know!!! :)
        $art->title->raw;
        $art->description->plain;
        $art->link->html;
        $art->pub_date->meta;
        $art->as_xml->xml;

    }

# DESCRIPTION

Data::Feed is a frontend for feeds. It will attempt to guess what type of feed you are passing in, from this it will generate the appropriate feed object.



# AUTHOR

LNATION, `<thisusedtobeanemail at gmail.com>`

# BUGS

Please report any bugs or feature requests to `bug-data-feed at rt.cpan.org`, or through
the web interface at [http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Data-Feed](http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Data-Feed).  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Data::Feed

You can also look for information at:

- RT: CPAN's request tracker (report bugs here)

    [http://rt.cpan.org/NoAuth/Bugs.html?Dist=Data-Feed](http://rt.cpan.org/NoAuth/Bugs.html?Dist=Data-Feed)

- AnnoCPAN: Annotated CPAN documentation

    [http://annocpan.org/dist/Data-Feed](http://annocpan.org/dist/Data-Feed)

- CPAN Ratings

    [http://cpanratings.perl.org/d/Data-Feed](http://cpanratings.perl.org/d/Data-Feed)

- Search CPAN

    [http://search.cpan.org/dist/Data-Feed/](http://search.cpan.org/dist/Data-Feed/)

# ACKNOWLEDGEMENTS

# LICENSE AND COPYRIGHT

Copyright 2016 LNATION.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

[http://www.perlfoundation.org/artistic\_license\_2\_0](http://www.perlfoundation.org/artistic_license_2_0)

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

# POD ERRORS

Hey! **The above document had some coding errors, which are explained below:**

- Around line 117:

    You forgot a '=back' before '=head1'
