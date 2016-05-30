use strict;
use warnings;
use Data::Dumper;
use Data::Feed;

my $feed = Data::Feed->new();
my $feeds = $feed->parse( 'http://feeds.feedburner.com/techcrunch/social?format=xml' );

warn Dumper $feed->all;
