package Mathcat::Monad::Impls;
use strict;
use warnings;
use Mathcat::Functor;
use Mathcat::Functor::Impls qw/$LIST_FUNCTOR $STATE_FUNCTOR/;
use Mathcat::NaturalTransformation qw/nat/;
use Mathcat::Monad;
use Mathcat::Morphism::Subroutine;
use base Exporter::;
our $VERSION = '0.01';

our @EXPORT_OK = qw/$LIST_MONAD $STATE_MONAD/;


our $LIST_MONAD = Mathcat::Monad->new(
	functor => $LIST_FUNCTOR,

	# All components were same for any ids in the category of subroutines.
	eta     => nat { sub_morph { [ @_ ] } },
	mu      => nat { sub_morph { map { @$_ } @_ } },
);


our $STATE_MONAD = Mathcat::Monad->new(
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
			my ($state_values, $states) = $state_state_value->( @_ );
			die 'Unknown type of arguments.' unless @$state_values == 1;
			return $state_values->[0]->( @$states );
		};
	} },
);

1;
