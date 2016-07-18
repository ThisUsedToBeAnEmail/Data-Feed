use strict;
use warnings;
use Test::More;
use Data::Dumper;

BEGIN {
    use_ok("Data::Feed");
}

my $feed = Data::Feed->new();
$feed->parse( 'https://litmus.com/blog/feed/' );

foreach my $f ( $feed->all ) {
    warn Dumper $f->category->raw;
    warn Dumper $f->category->text;
    warn Dumper $f->category->json;
}


done_testing();

1;
