use strict;
use warnings;
use Data::Dumper;
use Data::Feed;

my $feed = Data::Feed->new();
my @results = $feed->parse(URI->new('http://feeds.feedburner.com/techcrunch/social?format=xml'));

foreach my $item ( @results ) {
    warn Dumper $item->plain_text;
}

