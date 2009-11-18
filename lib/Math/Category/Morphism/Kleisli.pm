package Math::Category::Morphism::Kleisli;
use Moose;
our $VERSION = '0.1';

extends 'Math::Category::Morphism';

# Monad M
has monad    => (is => 'ro', isa => 'Math::Category::Monad'   , required => 1);
# Kleisli arrow: A -> M B
has morphism => (is => 'ro', isa => 'Math::Category::Morphism', required => 1);
# ID arrow: B -> B
has orig_target => (
	is       => 'ro', 
	isa      => 'Math::Category::Morphism', 
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
no  Moose;
1;
