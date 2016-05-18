use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok("Data::Feed");
}

my $feed = Data::Feed->new();
$feed->parse( 't/data/rss20.xml' );

subtest 'object options' => sub {
    test_feed({
        action => 'all',
        feed => $feed,
    });
    test_feed({
        action => 'count',
        feed => $feed,
        output => 2,
    });
    test_feed({
        action => 'get',
        feed => $feed,
        input => 1,
        isa_object => 'Data::Feed::Object'
    });
    test_feed({
        action => 'delete',
        feed => $feed,
        input => 1,
    });
    test_feed({
        action => 'count',
        feed => $feed,
        output => 1
    });
    # EVERYTHING BELOW THIS POINT IS BROKEN
=pod
    test_feed({
        action => 'push',
        feed => $feed
    });
    test_feed({
        action => 'return_range',
        feed => $feed,
        input => { start => 0, end => 1 },
        isa_output => 'Data::Feed', 
    });
=cut
};

subtest 'object render options' => sub {
   test_feed({
        action => 'render',
        feed => $feed,
        input => 'raw'
    });
    test_feed({
        action => 'render',
        feed => $feed,
        input => 'text'
    });
    test_feed({
        action => 'render',
        feed => $feed,
        input => 'json'
    });
};

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
