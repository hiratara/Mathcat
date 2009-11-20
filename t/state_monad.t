use strict;
use warnings;
use Test::More tests => 8;
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

# Monad raw (identity) -----------------------
my $nat1 = $STATE_MONAD->mu .
          (funct_nat $STATE_MONAD->functor, $STATE_MONAD->eta    );
my $nat2 = $STATE_MONAD->mu .
          (nat_funct $STATE_MONAD->eta    , $STATE_MONAD->functor);

my $state_value3 = sub {
	my @states = @_;
	my $v1 = shift @states;
	my $v2 = shift @states;
	return [$v1, $v2], [ @states, 'A', 'B' ];
};
my $state_value4 = $nat1->( $id_sub )->($state_value3);
# $state_value4 shoud be $state_value3
my ($value4, $state4) = $state_value4->('X', 'Y');
is_deeply $value4, [ qw/X Y/ ];
is_deeply $state4, [ qw/A B/ ];

my $state_value5 = $nat2->( $id_sub )->($state_value3);
# $state_value5 shoud be $state_value3
my ($value5, $state5) = $state_value5->('1', '2');
is_deeply $value5, [ qw/1 2/ ];
is_deeply $state5, [ qw/A B/ ];


# Monad raw (associative)---------------
# TODO: implement
