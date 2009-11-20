package Math::Category::Monad::Impls;
use Moose;
use Math::Category::Functor;
use Math::Category::Functor::Impls qw/$LIST_FUNCTOR $STATE_FUNCTOR/;
use Math::Category::NaturalTransformation qw/nat/;
use Math::Category::Monad;
use Math::Category::Morphism::Subroutine;
use base Exporter::;
our $VERSION = '0.01';

our @EXPORT_OK = qw/$LIST_MONAD $STATE_MONAD/;


our $LIST_MONAD = Math::Category::Monad->new(
	functor => $LIST_FUNCTOR,

	# All components were same for any ids in the category of subroutines.
	eta     => nat { sub_morph { [ @_ ] } },
	mu      => nat { sub_morph { map { @$_ } @_ } },
);


our $STATE_MONAD = Math::Category::Monad->new(
	functor => $STATE_FUNCTOR,

	# All components were same for any ids in the category of subroutines.
	eta => nat { sub_morph {
		my @value = @_;
		return sub {
			my @state = @_;
			return \@value, \@state;
		};
	} },
	mu  => nat { sub_morph {
		my $state_state_value = shift;
		return sub {
			my ($state_value, $state) = $state_state_value->( @_ );
			return $state_value->( @$state );
		};
	} },
);


__PACKAGE__->meta->make_immutable;
no  Moose;
1;
