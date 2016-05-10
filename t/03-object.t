use strict;
use warnings;

use Test::More;
use Data::Dumper;

BEGIN {
    use_ok("Data::Feed");
}

my $feed = Data::Feed->new();
$feed->parse( 't/data/rss20.xml' );

isa_ok($feed, "Data::Feed");
is( $feed->count, 2 );

subtest 'object render options' => sub {
    test_return_object({
        action => 'render',
        type => 'text',
        feed => $feed,
        output => q{},
    });
};

subtest 'object hash options' => sub {
    test_return_object({
        action => 'hash',
        type => 'text',
        feed => $feed,
        output => q{}
    });
};

done_testing();

sub test_return_object {
    my ($args) = @_;

    my $feed = $args->{feed};
    my $object = $feed->get(0);
    my $action = $args->{action};
    my $type = $args->{type};
    my $content = $object->$action($type);
    warn Dumper $content; 
    is($content, $args->{output}, "Correct Output: $action - $args->{type}");
}

1;
