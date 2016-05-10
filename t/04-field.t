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

subtest 'object options' => sub {
    test_object{
        action => 'edit',
        feed => $feed
    };
};

done_testing();

sub test_object {
    my ($args) = @_;

    foreach my $entry ( $feed->all ) {
        my $field_type = $args->{field};
        ok($entry->$field_type);

        my $field = $entry->$field_type;
    
        my $action = $arg->{action};
        ok($field->$action);
    }
}

1;
