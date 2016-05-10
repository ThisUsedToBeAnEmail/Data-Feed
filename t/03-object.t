use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok("Data::Feed");
}

my $feed = Data::Feed->new();
$feed->parse( 't/data/rss20.xml' );

isa_ok($feed, "Data::Feed");
is( $feed->count, 2 );

subtest 'object render options' => sub {
    test_object{
        action => 'as_raw',
        feed => $feed
    };
    test_object{
        action => 'as_html',
        feed => $feed
    };
    test_object{
        action => 'as_xml',
        feed => $feed
    };
    test_object{
        action => 'as_plain',
        feed => $feed
    };
    test_object{
        action => 'as_meta',
        feed => $feed
    };
};

subtest 'object hash options' => sub {
    test_object{
        action => 'as_hash_raw',
        feed => $feed
    };
    test_object{
        action => 'as_hash_html',
        feed => $feed
    };
    test_object{
        action => 'as_hash_xml',
        feed => $feed
    };
    test_object{
        action => 'as_hash_plain',
        feed => $feed
    };
    test_object{
        action => 'as_hash_meta',
        feed => $feed
    };
};

subtest 'object options' => sub {
    test_object{
        action => 'edit',
        feed => $feed
    };
    test_object{
        action => 'delete',
        feed => $feed
    };
};

subtest 'object fields' => sub {
    test_object{
        action => 'title',
        feed => $feed
    };
    test_object{
        action => 'description',
        feed => $feed
    };
    test_object{
        action => 'link',
        feed => $feed
    };
    test_object{
        action => 'pub_date',
        feed => $feed
    };
    test_object{
        action => 'as_xml',
        feed => $feed
    };
};

done_testing();

sub test_object {
    my ($args) = @_;

    my $feed = $args->{feed};

    foreach my $entry ( $feed->all ) {
        my $action = $args->{action};
        ok($entry->$action);
    }
}

1;
