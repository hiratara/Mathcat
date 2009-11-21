package Math::Category::Monad::Maybe;
use strict;
use warnings;
use Sub::Exporter;
use Math::Category::Functor;
use Math::Category::Functor::Impls qw/$MAYBE_FUNCTOR/;
use Math::Category::NaturalTransformation qw/nat/;
use Math::Category::Monad;
use Math::Category::Morphism::Subroutine;
use Math::Category::Morphism::Kleisli;
our $VERSION = '0.01';

my @export = qw/just nothing maybe_kleisli eval_maybe/;
Sub::Exporter::setup_exporter( { 
	exports => \@export,
	groups  => { default => \@export, }, 
} );


our $MAYBE_MONAD = Math::Category::Monad->new(
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
*just = \&{ $MAYBE_MONAD->eta->( $Math::Category::Morphism::Subroutine::ID ) };

sub nothing(){ undef }

# A kleisli define identifier.
sub maybe_kleisli(&){
	my $code = shift;

	return Math::Category::Morphism::Kleisli->new(
		monad       => $MAYBE_MONAD,
		morphism    => &sub_morph( $code ),
		# All ids are considered as sub { @_ } in the category of subroutines.
		orig_target => $Math::Category::Morphism::Subroutine::ID,
	);
}


sub eval_maybe{
	my $maybe_kleisli = shift;
	return $maybe_kleisli->morphism->( @_ );
}


1;
