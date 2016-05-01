use strict;
use warnings;
use Data::Dumper;
use Data::Feed;

my $feeds = Data::Feed->parse( URI->new('http://feeds.bbci.co.uk/news/technology/rss.xml') );

foreach my $feed (@{ $feeds }) {
}
