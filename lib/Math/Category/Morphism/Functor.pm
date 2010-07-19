package Math::Category::Morphism::Functor;
use Any::Moose;
use Sub::Exporter;
use Math::Category::NaturalTransformation -all => { -prefix => 'any_', };
use overload '&{}' => sub { my $s = shift; sub { $s->nat->(@_); }; };
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

sub new_with_nat {
	my $class = shift;
	my ( $natural_transformation ) = @_;
	return $class->new( natural_transformation => $natural_transformation );
}

sub source { 
	my $self = shift;
	return functor_morph any_nat {
		my $id = shift;
		return $self->( $id )->source;
	};
}

sub target { 
	my $self = shift;
	return functor_morph any_nat {
		my $id = shift;
		return $self->( $id )->target;
	};
}

sub composition {
	my $self  = shift;
	my $morph = shift;
	return functor_morph $self->nat . $morph->nat;
}

__PACKAGE__->meta->make_immutable;
no  Any::Moose;

1;
