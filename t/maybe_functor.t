use strict;
use warnings;
use Test::More tests => 1;
use Mathcat::Morph::Sub;
use Mathcat::Funct::Impls qw/$MAYBE_FUNCTOR/;


my $morph = $MAYBE_FUNCTOR->( sub_morph { return reverse @_; } );

is_deeply $morph->( [ 1, 2, 3 ] ), [3, 2, 1];
