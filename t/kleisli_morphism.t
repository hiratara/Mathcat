use strict;
use warnings;
use Test::More tests => 1;
use Math::Category::Impl::KleisliMorphism;
use Math::Category::Impl::SubroutineMorphism;
use Math::Category::Impl::Monads qw/$LIST_MONAD/;

# Composition
my $morph1 = Math::Category::Impl::KleisliMorphism->new(
	monad       => $LIST_MONAD,
	morphism    => sub_morph { ( [ 'xyz' ] ) x $_[0] },
	orig_target => $Math::Category::Impl::SubroutineMorphism::ID,
);

my $morph2 = Math::Category::Impl::KleisliMorphism->new(
	monad       => $LIST_MONAD,
	morphism    => sub_morph { map { [$_] } split //, $_[0] },
	orig_target => $Math::Category::Impl::SubroutineMorphism::ID,
);

my $morph3 = $morph2 . $morph1;

is_deeply [ $morph3->morphism->( 2 ) ], 
          [ ['x'], ['y'], ['z'], ['x'], ['y'], ['z'], ];
