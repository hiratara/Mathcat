use strict;
use warnings;
use Test::More tests => 1;
use Math::Category::Morphism::Subroutine;
use Math::Category::Functor::Impls qw/$MAYBE_FUNCTOR/;


my $morph = $MAYBE_FUNCTOR->( sub_morph { return reverse @_; } );

is_deeply $morph->( [ 1, 2, 3 ] ), [3, 2, 1];
