use strict;
use warnings;
use Test::More;
use Data::Dumper;

BEGIN {
    use_ok("Data::Feed");
}

my $feed = Data::Feed->new();
$feed->parse( 'http://www.foxtons.co.uk/feeds?price_from=0&price_to=175&location_ids=296&search_type=LL&result_view=rss' );

warn Dumper $feed->render('json');

done_testing();

sub test_feed {
    my ($args) = @_;

    my $feed = $args->{feed};
    my $action = $args->{action};
    my $input = $args->{input};
    my $output = $args->{output};
    my $isa_object = $args->{isa_object};
    my $test;

    if ($input) {
        ok($test = $feed->$action($input));
    }
    else {
        ok($test = $feed->$action);
    }

    if ($output) {
        is($test, $output, "correct output: $action");
    }
    elsif ($isa_object) {
       isa_ok($test, $isa_object, "correct output: $action");
    }
}

1;
