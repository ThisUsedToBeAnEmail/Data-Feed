package Data::Feed::Parser::Atom;

use Moose;
extends 'Data::Feed::Parser::Base';
use XML::Atom::Feed;

our $VERSION = '0.01';

has '+parser' => (
    default => sub {
        my $self = shift;
        return XML::Atom::Feed->new($self->content_ref);
    }
);

sub get_value {
    my ($self, $item, $action) = @_;
    
    return $item->$action ? $item->$action : '';
}

__PACKAGE__->meta->make_immutable;

1; # End of Data::Feed
