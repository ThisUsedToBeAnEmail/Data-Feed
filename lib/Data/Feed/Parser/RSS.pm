package Data::Feed::Parser::RSS;

use Moose;
extends 'Data::Feed::Parser::Base';
use XML::RSS::LibXML;
use Ref::Util ':all';

our $VERSION = '0.01';

has '+parser' => (
    default => sub {
        my $self = shift;
        return XML::RSS::LibXML->new->parse($self->content_ref);
    },
);

sub get_value {
    my ($self, $item, $action) = @_;
   
    my $value = $item->{$action};

    if ( is_scalarref(\$value) ){
        return $value;
    }
    elsif ( is_arrayref($value)){
        return join ', ', @{ $value };
    }
    elsif ( is_hashref($value) ){
        return $value->{encoded};
    }
    else {
        return '';
    }
}

__PACKAGE__->meta->make_immutable;

1; # End of Data::Feed
