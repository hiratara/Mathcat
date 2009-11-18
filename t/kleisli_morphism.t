use strict;
use warnings;
use Test::More tests => 1;
use Math::Category::Morphism::Kleisli;
use Math::Category::Morphism::Subroutine;
use Math::Category::Monad::Impls qw/$LIST_MONAD/;

# Composition
my $morph1 = Math::Category::Morphism::Kleisli->new(
	monad       => $LIST_MONAD,
	morphism    => sub_morph { ( [ 'xyz' ] ) x $_[0] },
	orig_target => $Math::Category::Morphism::Subroutine::ID,
);

my $morph2 = Math::Category::Morphism::Kleisli->new(
	monad       => $LIST_MONAD,
	morphism    => sub_morph { map { [$_] } split //, $_[0] },
	orig_target => $Math::Category::Morphism::Subroutine::ID,
);

my $morph3 = $morph2 . $morph1;

is_deeply [ $morph3->morphism->( 2 ) ], 
          [ ['x'], ['y'], ['z'], ['x'], ['y'], ['z'], ];
