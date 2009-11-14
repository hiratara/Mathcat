package Math::Category::Impl::FunctorMorphism;
use Moose;
use Sub::Exporter;
use Math::Category::Impl::AnyNaturalTransformation 
                                                -all => { -prefix => 'any_', };
our $VERSION = '0.01';

extends 'Math::Category::Morphism';

has natural_transformation => (
	isa      => 'Math::Category::NaturalTransformation',
	is       => 'ro',
	required => 1,
);

# shortcut
*nat = \&natural_transformation;

my @export = qw/functor_morph/;
Sub::Exporter::setup_exporter( { 
	exports => \@export,
	groups  => { default => \@export, }, 
} );

sub functor_morph ($){
	__PACKAGE__->new_with_nat( @_ );
}

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
	return functor_morph( any_nat {
		my $id = shift;
		return $self->nat->($id) . $morph->nat->($id);
	} );
}

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
