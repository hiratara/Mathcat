package Mathcat::Morphism::Simple;
use Any::Moose;
use Sub::Exporter;
our $VERSION = '0.01';

extends 'Mathcat::Morphism';

has source_object => (
	isa      => 'Str',
	is       => 'ro',
	required => 1,
);

has target_object   => (
	isa      => 'Str',
	is       => 'ro',
	required => 1,
);

# shortcut
*from = \&source_object;
*to   = \&target_object;


my @export = qw/simple_morph/;
Sub::Exporter::setup_exporter( { 
	exports => \@export,
	groups  => { default => \@export, }, 
} );

sub simple_morph ($$){
	__PACKAGE__->new( source_object => $_[0], target_object => $_[1], );
}

sub source      { 
	my $self = shift;
	return simple_morph $self->from => $self->from;
}
sub target      { 
	my $self = shift;
	return simple_morph $self->to => $self->to;
}
sub composition {
	my $self     = shift;
	my $morphism = shift;
	return simple_morph $morphism->from => $self->to;
}

__PACKAGE__->meta->make_immutable;
no  Any::Moose;
1;
