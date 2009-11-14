package Math::Category::Impl::FunctorMorphism;
use Moose;
our $VERSION = '0.01';
use Math::Category::Impl::AnyNaturalTransformation -all => {
	-prefix => 'any_',
};

extends 'Math::Category::Morphism';

has natural_transformation => (
	isa      => 'Math::Category::NaturalTransformation',
	is       => 'ro',
	required => 1,
);

our $ID = any_nat {
	my $id;
	return $id;
};

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
		any_nat {
			my $id = shift;
			return $self->natural_transformation->($id) . 
			       $morph->natural_transformation->($id);
		}, 
	);
}

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
