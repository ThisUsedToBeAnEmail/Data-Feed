#!/use/bin/perl

use URI;
use Web::Scraper;
use Encode;
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

warn Dumper \%seen;
warn Dumper scalar keys %seen;

1;
