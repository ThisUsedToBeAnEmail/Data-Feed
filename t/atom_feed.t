use strict;
use warnings;
use Data::Dumper;
use Data::Feed;

my $feeds = Data::Feed->parse( URI->new('http://use.perl.org/index.atom') );

foreach my $feed (@{ $feeds }) {
    warn Dumper $feed->title;
    warn Dumper $feed->description;
}
