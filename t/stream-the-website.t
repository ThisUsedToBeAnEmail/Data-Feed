#!/use/bin/perl
use strict;
use warnings;
use Test::More;

use URI;
use Web::Scraper;
use Encode;
use Data::Feed;

use Data::Dumper;

my $uri = "https://www.techcrunch.com";

my $endpoints = scraper {
    process 'a', "links[]" => '@href';
};

my $res = $endpoints->scrape(URI->new($uri));
my %seen;
foreach my $author (@{ $res->{links} }){
    my $link = $author->as_string;
    $seen{$link}++;
}

my $feed = Data::Feed->new();
my $count = 0;
for my $l  (keys %seen) {
    $count++;
    next if $l =~ m{mailto};
    $feed->parse($l);

    last if $count == 20;
};

warn Dumper $feed->count;

foreach my $ff ( $feed->all ) {
    warn Dumper $ff->title->raw;
    warn Dumper $ff->description->raw;
}
