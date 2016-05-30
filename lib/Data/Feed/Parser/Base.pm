package Data::Feed::Parser::Base;

use Moose;
use Data::Feed::Object;

our $VERSION = '0.01';

has 'content_ref' => (
    is      => 'rw',
    lazy    => 1,
    default => q{},
);

has 'parser' => (
    is      => 'rw',
    lazy    => 1,
    default => q{},
);

has 'potential_fields' => (
    is      => 'rw',
    isa     => 'HashRef',
    lazy    => 1,
    default => sub { 
        return {
            title => 'title',
            description => 'description',
            date => 'pubDate',
            author => 'author',
            category => 'category',
            permalink => 'permaLink',  
            comment => 'comments',
            link => 'link',
        };
    },
);

has 'feed' => (
    is      => 'rw',
    lazy    => 1,
    default => sub { 
        my $self = shift;    
        
        my @feed;
        foreach my $item ( @{ $self->parser->{items} } ) {
            my %args;
            my $potential = $self->potential_fields;

            while (my ($field, $action) = each $potential) {
                if (my $value = $self->get_value($item, $action)){
                    $args{$field} = $value;
                }
            }

            my $object = Data::Feed::Object->new(object => \%args);
            push @feed, $object;
        }
    
        return \@feed;
    },
);

sub parse {
    my ($self, $content_ref) = shift;
    
    return $self->feed;
}

__PACKAGE__->meta->make_immutable;

1; # End of Data::Feed
