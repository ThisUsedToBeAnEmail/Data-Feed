package Data::Feed::Parser::Base;

use Moose;
use Data::Feed::Object;
use HTML::LinkExtor;

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
            content => 'content',
            image => 'image',
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

            while (my ($field, $action) = each %{ $potential }) {
                my $value;
                if ($value = $self->get_value($item, $action)){
                    $args{$field} = $value;
                }
                if ($action eq 'image' && !$value) {
                    my $content = $self->get_value($item, 'content');
                    next unless $content;
                    if ( $value = $self->first_image_tag($content) ){
                        $args{$field} = $value;
                    }
                }
            }

            my $object = Data::Feed::Object->new(object => \%args);
            push @feed, $object;
        }
    
        return \@feed;
    },
);

sub parse {
    my ($self) = shift;
    return $self->feed;
}

sub first_image_tag {
    my ($self, $content) = @_;

    my $p = HTML::LinkExtor->new;
    $p->parse($content);
    my @links = $p->links;
    for (@links) {
        my ($img, %attr) = @$_ if $_->[0] eq 'img';
        return $attr{src} if $img;
    }
}

__PACKAGE__->meta->make_immutable;

1; # End of Data::Feed
