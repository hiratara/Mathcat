package Math::Category::Impl::Bimorphism;
use Moose;
our $VERSION = '0.01';
extends 'Math::Category::Morphism';

has morphism1   => (
	isa      => 'Math::Category::Morphism',
	is       => 'ro',
	required => 1,
);

has morphism2   => (
	isa      => 'Math::Category::Morphism',
	is       => 'ro',
	required => 1,
);

sub source      { 
	my $self = shift;
	return __PACKAGE__->new(
		morphism1 => $self->morphism1->source,
		morphism2 => $self->morphism2->source,
	);
}
sub target      {
	my $self = shift;
	return __PACKAGE__->new(
		morphism1 => $self->morphism1->target,
		morphism2 => $self->morphism2->target,
	);
}
sub composition {
	my $self     = shift;
	my $morphism = shift;
	return __PACKAGE__->new(
		morphism1 => $self->morphism1 . $morphism->morphism1, 
		morphism2 => $self->morphism2 . $morphism->morphism2, 
	);
}

__PACKAGE__->meta->make_immutable;
no  Moose;
1;
