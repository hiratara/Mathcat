package Math::Category::Impl::SimpleMorphism;
use Moose;
our $VERSION = '0.01';
extends 'Math::Category::Morphism';

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

sub source      { 
	my $self = shift;
	return __PACKAGE__->new(
		source_object => $self->source_object,
		target_object => $self->source_object,
	);
}
sub target      { 
	my $self = shift;
	return __PACKAGE__->new(
		source_object => $self->target_object,
		target_object => $self->target_object,
	);
}
sub composition {
	my $self     = shift;
	my $morphism = shift;
	return __PACKAGE__->new(
		source_object => $morphism->source_object,
		target_object => $self->target_object,
	);
}

__PACKAGE__->meta->make_immutable;
no  Moose;
1;
