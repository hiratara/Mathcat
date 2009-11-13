package Math::Category::Impl::FunctorMorphism;
use Moose;
our $VERSION = '0.01';
use Math::Category::Impl::AnyNaturalTransformation;

extends 'Math::Category::Morphism';

has natural_transformation => (
	isa      => 'Math::Category::NaturalTransformation',
	is       => 'ro',
	required => 1,
);

our $ID = Math::Category::Impl::AnyNaturalTransformation->new( sub {
	my $id;
	return $id;
} );

sub new_with_nat {
	my $class = shift;
	my ( $natural_transformation ) = @_;
	return $class->new( natural_transformation => $natural_transformation );
}

sub source      { return $ID; }
sub target      { return $ID; }
sub composition {
	my $self  = shift;
	my $morph = shift;
	return __PACKAGE__->new_with_nat(
		Math::Category::Impl::AnyNaturalTransformation( sub {
			my $id = shift;
			return $self->natural_transformation->($id) . 
			       $morph->natural_transformation->($id);
		} )
	);
}

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
