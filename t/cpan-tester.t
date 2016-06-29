use strict;
use warnings;
use Test::More;
use Data::Dumper;

BEGIN {
    use_ok("Data::Feed");
}

my $feed = Data::Feed->new();
$feed->parse( 'http://www.cpantesters.org/author/LNATION.rss' );

warn Dumper $feed->render('json');

done_testing();

1;
