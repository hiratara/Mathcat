use strict;
use warnings;
use Test::More tests => 4;
use Math::Category::Morphism::Subroutine;
use Math::Category::NaturalTransformation qw/nat_funct funct_nat/;
use Math::Category::Monad::Impls qw/$STATE_MONAD/;


my $id_sub = $Math::Category::Morphism::Subroutine::ID;

# Nats
my $state_value1 = $STATE_MONAD->eta->( $id_sub )->( 'a', 'b', 'c' );
my ( $value1, $state1 ) = $state_value1->( qw/dummy1 dummy2 dummy3/ );
is_deeply $value1, [ 'a', 'b', 'c' ];
is_deeply $state1, [ qw/dummy1 dummy2 dummy3/ ];

# TODO: implement tests of mu
my $state_state_value = sub {
	my @states = @_;
	return [ sub {
		my @inner_states = @_;
		return [@states, @inner_states], [ @inner_states, 'in' ];
	} ], [@states, 'out'];
};
my $state_value2 = $STATE_MONAD->mu->( $id_sub )->( $state_state_value );
my ( $value2, $state2 ) = $state_value2->( qw/dummy1 dummy2 dummy3/ );
is_deeply $value2, [ qw/dummy1 dummy2 dummy3 dummy1 dummy2 dummy3 out/ ];
is_deeply $state2, [ qw/dummy1 dummy2 dummy3 out in/ ];

# Monad raw (identity)
# TODO: implement

# Monad raw (associative)
# TODO: implement
