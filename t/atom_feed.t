use strict;
use warnings;
use Data::Dumper;
use Data::Feed;

my $feed = Data::Feed->new();
my $feeds = $feed->parse( URI->new('http://feeds.feedburner.com/techcrunch/social?format=xml') );

foreach my $fee (@{ $feeds }) {
    warn Dumper $fee->plain_text;
}
