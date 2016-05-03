use strict;
use warnings;
use Data::Dumper;
use Data::Feed;

my $feed = Data::Feed->new();
$feed->parse(URI->new('http://feeds.feedburner.com/techcrunch/social?format=xml'));

warn Dumper $feed->count;
$feed->delete(10);
warn Dumper $feed->count;

my $article = $feed->get(2);
warn Dumper $article->title->plain_text;

foreach my $item ( $feed->all ) {
    warn Dumper $item->title->plain_text;
}

