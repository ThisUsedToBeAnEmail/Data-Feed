#!/use/bin/perl
use strict;
use warnings;
use Test::More;

use URI;
use Web::Scraper;
use Encode;
use Data::Feed;

use Data::Dumper;

my $uri = "http://www.bbc.co.uk/technology";

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
for my $l  (keys %seen) {
    next if $l =~ m{mailto};
    $feed->parse($l);

    last if $feed->count == 20;
};

warn Dumper $feed->count;

foreach my $ff ( $feed->all ) {
    warn Dumper $ff->title->text;
    warn Dumper $ff->description->text;
}
