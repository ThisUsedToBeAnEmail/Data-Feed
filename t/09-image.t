use strict;
use warnings;
use Test::More;
use Data::Dumper;

BEGIN {
    use_ok("Data::Feed");
}

my $feed = Data::Feed->new();
$feed->parse( 'https://litmus.com/blog/feed/' );

warn Dumper $feed->count;
foreach my $f ( $feed->all ) {
    warn Dumper $f->image->raw;
    warn Dumper $f->image->text;
    warn Dumper $f->image->json;
}


done_testing();

1;
