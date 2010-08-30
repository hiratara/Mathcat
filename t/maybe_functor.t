use strict;
use warnings;
use Test::More tests => 1;
use Mathcat::Morphism::Subroutine;
use Mathcat::Functor::Impls qw/$MAYBE_FUNCTOR/;


my $morph = $MAYBE_FUNCTOR->( sub_morph { return reverse @_; } );

is_deeply $morph->( [ 1, 2, 3 ] ), [3, 2, 1];
