use strict;
use warnings;
use Test::More tests => 1;
use Mathcat::Morph::Kleisli;
use Mathcat::Morph::Sub;
use Mathcat::Monad::Impls qw/$LIST_MONAD/;

# Composition
my $morph1 = Mathcat::Morph::Kleisli->new(
	monad       => $LIST_MONAD,
	morphism    => sub_morph { ( [ 'xyz' ] ) x $_[0] },
	orig_target => $Mathcat::Morph::Sub::ID,
);

my $morph2 = Mathcat::Morph::Kleisli->new(
	monad       => $LIST_MONAD,
	morphism    => sub_morph { map { [$_] } split //, $_[0] },
	orig_target => $Mathcat::Morph::Sub::ID,
);

my $morph3 = $morph2 . $morph1;

is_deeply [ $morph3->morphism->( 2 ) ], 
          [ ['x'], ['y'], ['z'], ['x'], ['y'], ['z'], ];
