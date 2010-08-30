package Mathcat::Morphism::Kleisli;
use Any::Moose;
our $VERSION = '0.1';

extends 'Mathcat::Morphism';

# Monad M
has monad    => (is => 'ro', isa => 'Mathcat::Monad'   , required => 1);
# Kleisli arrow: A -> M B
has morphism => (is => 'ro', isa => 'Mathcat::Morphism', required => 1);
# ID arrow: B -> B
has orig_target => (
	is       => 'ro', 
	isa      => 'Mathcat::Morphism', 
	required => 1
);

sub source      { 
	my $self = shift;
	return __PACKAGE__->new(
		monad       => $self->monad,
		morphism    => $self->monad->eta->( $self->morphism->source ),
		orig_target => $self->morphism->source,
	);
}
sub target      { 
	my $self = shift;
	return __PACKAGE__->new(
		monad       => $self->monad,
		morphism    => $self->monad->eta->( $self->orig_target ),
		orig_target => $self->orig_target,
	);
}
sub composition {
	my $self     = shift;
	my $morphism = shift;

	return __PACKAGE__->new(
		monad       => $self->monad,
		morphism    => $self->monad->mu->( $self->orig_target ) . 
		               $self->monad->( $self->morphism ) . $morphism->morphism,
		orig_target => $self->orig_target,
	);
}

__PACKAGE__->meta->make_immutable;
no  Any::Moose;
1;
