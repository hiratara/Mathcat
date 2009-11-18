use strict;
use warnings;
use Test::More tests => 8;
use Math::Category::Morphism::Subroutine;
use Math::Category::NaturalTransformation qw/nat_funct funct_nat/;
use Math::Category::Impl::Monads qw/$LIST_MONAD/;

# the Functor
my $morph = $LIST_MONAD->( sub_morph { join ',', @_ } );
is_deeply [ $morph->( ["abc", "e", "hi"], ["l", "mn", "opq"],  ) ],
          [ [ "abc,e,hi" ], [ "l,mn,opq" ] ];

# Nats
my $id_sub = $Math::Category::Morphism::Subroutine::ID;
is_deeply [ $LIST_MONAD->eta->( $id_sub )->( 'a', 'b', 'c' ) ],
          [ ['a', 'b', 'c' ] ];
is_deeply [ $LIST_MONAD->mu->( $id_sub )->( 
              [ [ 'a', 'b', 'c' ], [ 'c', 'd', 'e' ] ], [ [ 'f', 'g' ] ],
          ) ], 
          [ [ 'a', 'b', 'c' ], [ 'c', 'd', 'e' ], [ 'f', 'g' ] ];

is_deeply [ $LIST_MONAD->mu->( $id_sub )->( 
              [ ['a'], ['b'], ['c'] ], [ ['c'], ['d'], ['e'] ],
          ) ], 
          [ ['a'], ['b'], ['c'], ['c'], ['d'], ['e'] ];

# Monad raw (identity)
my $nat1 = $LIST_MONAD->mu .
          (funct_nat $LIST_MONAD->functor, $LIST_MONAD->eta    );
my $nat2 = $LIST_MONAD->mu .
          (nat_funct $LIST_MONAD->eta    , $LIST_MONAD->functor);

is_deeply [$nat1->( $id_sub )->( ['AZC'] )], [ ['AZC'] ];
is_deeply [$nat2->( $id_sub )->([1], [2])], [[1], [2]];

# Monad raw (associative)
my $nat3 = $LIST_MONAD->mu .
          (funct_nat $LIST_MONAD->functor, $LIST_MONAD->mu     );
my $nat4 = $LIST_MONAD->mu .
          (nat_funct $LIST_MONAD->mu     , $LIST_MONAD->functor);

is_deeply [$nat3->( $id_sub )->(
	[ [ ['A'], ['B'] ], [ [ 'C1', 'C2' ] ]  ], [ [ [ 'D' ] ] ]
)], [ ['A'], ['B'], ['C1', 'C2'], ['D'] ];
is_deeply [$nat4->( $id_sub )->(
	[ [ ['A'], ['B'] ], [ [ 'C1', 'C2' ] ]  ], [ [ [ 'D' ] ] ]
)], [ ['A'], ['B'], ['C1', 'C2'], ['D'] ];
