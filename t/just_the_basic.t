use strict;
use warnings;
use Test::More;
use Data::Dumper;

BEGIN {
    use_ok("Data::Feed");
}

my $feed = Data::Feed->new();
$feed->parse( 't/data/rss20.xml' );

warn Dumper $feed->count;

$feed->write( 't/data/empty.xml' );


