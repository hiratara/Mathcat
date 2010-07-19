use strict;
use warnings;
use Test::More tests => 4;
use Math::Category::Morphism::Subroutine;
use Math::Category::Monad::Maybe;
use Math::Category::Monad::Sugars;

my $div = maybe_kleisli { $_[1] == 0 ? nothing : just $_[0] / $_[1] };

sub divs($){
	my $first_divisor = shift;

	eval_maybe(maybe_kleisli {
			my $v1 = shift;
			eval_maybe(maybe_kleisli {
				my $v2 = shift;
				eval_maybe($div => $v1, $v2);
			} . maybe_kleisli { eval_maybe($div => 2.0, 1.0) } => undef);
	} . maybe_kleisli { eval_maybe($div => 3.0, $first_divisor) } => undef);
}

my $divs = do_expression {
	my $first_divisor = shift;
	my ($v1) = coro eval_maybe($div => 3.0, $first_divisor);
	my ($v2) = coro eval_maybe($div => 2.0, 1.0);
	my ($v3) = coro eval_maybe($div => $v1, $v2);

	return just $v3;
};

is divs(0.0), undef;
is_deeply divs(1.0), [1.5];

is_deeply $divs->(1.0), [1.5];
is $divs->(0.0), undef;
