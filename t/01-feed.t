use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok("Data::Feed");
}

my $feed = Data::Feed->new();
$feed->parse( 't/data/rss20.xml' );

subtest 'feed options' => sub {
    plan tests => 13;
    test_options({
        action => 'all',
        feed => $feed,
    });
    test_options({
        action => 'count',
        feed => $feed,
        output => 2,
    });
    test_options({
        action => 'get',
        feed => $feed,
        input => 1,
        isa_object => 'Data::Feed::Object'
    });
    test_options({
        action => 'pop',
        feed => $feed,
        isa_object => 'Data::Feed::Object'
    });
    test_options({
        action => 'insert',
        feed => $feed,
        input =>  bless( { 
            'object' => {
                'title' => 'Entry Two',
                'link' => 'http://localhost/weblog/2004/05/entry_two.html',
                'description' => 'Hello!...',
                'pub_date' => 'Sat, 29 May 2004 23:39:25 -0800'
            } }, 'Data::Feed::Object' ),
        count => 2,
    });         
    test_options({
        action => 'delete',
        feed => $feed,
        input => 1,
        count => 1,
    });
   test_options({
        action => 'pop', # cant call delete on index 0
        feed => $feed,
    });
    test_options({
        action => 'is_empty',
        feed => $feed,
    });
};

subtest 'feed parse' => sub {
    plan skip_all => 'fix fields first';
};

subtest 'feed render' => sub {
    plan skip_all => 'fix fields first';
};

subtest 'feed hash' => sub {
    plan skip_all => 'fix fields first';
};

subtest 'feed write' => sub {
    plan skip_all => 'fix fields first';
};

done_testing();

sub test_options {
    my ($args) = @_;

    my $feed = $args->{feed};
    my $action = $args->{action};
    my $input = $args->{input};
    my $test;

    if ($input) {
        ok($test = $feed->$action($input), "action: $action");
    }
    else {
        ok($test = $feed->$action, "action: $action");
    }

    if (my $output = $args->{output}) {
        is($test, $output, "correct output for action: $action - $output");
    }
    elsif (my $isa_object = $args->{isa_object}) {
        $input ||= 'no input';
        isa_ok($test, $isa_object, "correct output for action: $action input: $input");
    }

    if (my $count = $args->{count}){
        is($feed->count, $count, "correct count: $count after action $action");
    }
}



1;
