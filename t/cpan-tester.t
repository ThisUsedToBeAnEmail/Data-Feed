use strict;
use warnings;
use Test::More;
use Data::Dumper;

BEGIN {
    use_ok("Data::Feed");
}

my $feed = Data::Feed->new();
$feed->parse( 'https://litmus.com/blog/feed/' );

warn Dumper $feed->generate('text');

done_testing();

1;
