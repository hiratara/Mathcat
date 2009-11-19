use strict;
use warnings;
use Test::More tests => 2;
use Math::Category::Morphism::Subroutine;
use Math::Category::Functor::Impls qw/$STATE_FUNCTOR/;


my $morph = $STATE_FUNCTOR->( sub_morph { map { $_ + 1 } @_; } );

my $state1 = sub {
	my @states = @_;
	return [ ( 1 ) x @states ], [ @states, 'Y' ];
};

my $state2 = $morph->( $state1 );

my ($values, $statuses) = $state2->( 'Y', 'Y' );

is_deeply $values  , [2, 2];
is_deeply $statuses, ['Y', 'Y', 'Y'];
