use strict;
use warnings;
use Test::More tests => 4;
use Math::Category::Morphism::Subroutine;
use Math::Category::Monad::Maybe;

is_deeply just(1, 2, 3), [ 1, 2, 3];
ok ! defined nothing;

my $div = maybe_kleisli { $_[1] == 0 ? nothing : just $_[0] / $_[1] };
my $bar = maybe_kleisli { return just( 'x' x $_[0] ) };
my $divbar = $bar . $div;

is_deeply eval_maybe($divbar, 4, 2), [ 'xx' ];
is eval_maybe($divbar, 3, 0), undef;
