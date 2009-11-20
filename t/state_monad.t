use strict;
use warnings;
use Test::More tests => 2;
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

# Monad raw (identity)
# TODO: implement

# Monad raw (associative)
# TODO: implement
