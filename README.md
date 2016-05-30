# NAME

Data::Feed

# VERSION

Version 0.5

# SYNOPSIS 

    use Data::Feed;

    my $feed = Data::Feed->new();
    $feed->parse( '***' );

    $feed->all;
    $feed->count;
    $feed->delete(Index1, Index2..);
    $feed->get(Index1, Index2..);

    $feed->write( 'path/to/empty.xml' );
    my $feed_text = $feed->render('text'); # TODO make Object an array of hash refs

    foreach my $object ( $feed->all ) {
        $object->render('text'); # text, html, xml..
        $object->hash('text'); # text, html, xml...
        $object->fields('title', 'description'); # returns title and description object
        $object->edit(title => 'WoW', description => 'something amazing'); # sets
        
        # missing fields
        $object->title->raw;
        $object->link->raw;
        $object->description->raw;
        $object->image->raw;
        $object->date->raw;
        
        # missing lots
        $entry->title->as_text;
    }

# DESCRIPTION

Data::Feed is a frontend for building dynamic data feeds.

# Methods

## parse

Populates the feed Attribute, this is an Array of Data::Feed::Object 's

You can currently build Feeds by parsing xml (RSS, ATOM) and static HTML via Meta Tags (twitter, opengraph);

- URI

        # any rss/atom feed or a web page that contains og or twitter markup
        $feed->parse( 'http://examples.com/feed.xml' );

- File

        $feed->parse( 'path/to/feed.xml' );

- Raw 

        $feed->parse( 'qq{<?xml version="1.0"><feed> .... </feed>} );

## all

returns all elements in the feed

## count

returns the count of the current data feed

## get

accepts an integer and returns an Data::Feed::Object from feed by its Array index

## pop

pop the first Data::Feed::Object from the current feed

## delete

accepts an integer and deletes the relevant Data::Feed::Object based on its Array index

## insert

insert an 'Data::Feed::Object' into the feed

## is\_empty

returns true if Data::Feed is empty.

## render

render the feed using the passed in format, defaults to text.

    # raw - as taken from the feed
    # text - stripped to plain text
    # json 

    $feed->render('raw');

## generate

returns the feed object as a Array of hashes but with the values rendered, key being the field. You can also pass in a format.

    $feed->hash('text');

# AUTHOR

# BUGS

Please report any bugs or feature requests to `bug-data-feed at rt.cpan.org`, or through
the web interface at [http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Data-Feed](http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Data-Feed).  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

# SUPPORT

You can find documentation for this module with the perldoc command.

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
