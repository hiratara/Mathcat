package Mathcat::Monad::Maybe;
use strict;
use warnings;
use Sub::Exporter;
use Mathcat::Functor;
use Mathcat::Functor::Impls qw/$MAYBE_FUNCTOR/;
use Mathcat::NaturalTransformation qw/nat/;
use Mathcat::Monad;
use Mathcat::Morphism::Subroutine;
use Mathcat::Morphism::Kleisli;
our $VERSION = '0.01';

my @export = qw/just nothing maybe_kleisli eval_maybe/;
Sub::Exporter::setup_exporter( { 
	exports => \@export,
	groups  => { default => \@export, }, 
} );


our $MAYBE_MONAD = Mathcat::Monad->new(
	functor => $MAYBE_FUNCTOR,

	# All components were same for any ids in the category of subroutines.
	eta     => nat { sub_morph { [ @_ ] } },
	mu      => nat { sub_morph {
		my $maybe_maybe_val = shift;
		return undef unless defined $maybe_maybe_val;
		return @$maybe_maybe_val;
	} },
);

sub just;
*just = \&{ $MAYBE_MONAD->eta->( $Mathcat::Morphism::Subroutine::ID ) };

sub nothing(){ undef }

# A kleisli define identifier.
sub maybe_kleisli(&){
	my $code = shift;

	return Mathcat::Morphism::Kleisli->new(
		monad       => $MAYBE_MONAD,
		morphism    => &sub_morph( $code ),
		# All ids are considered as sub { @_ } in the category of subroutines.
		orig_target => $Mathcat::Morphism::Subroutine::ID,
	);
}


sub eval_maybe{
	my $maybe_kleisli = shift;
	return $maybe_kleisli->morphism->( @_ );
}


1;
