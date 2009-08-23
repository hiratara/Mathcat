use strict;
use Test::More tests => 1;
use Math::Category::Impl::OppositeMorphism;
use Math::Category::Impl::Bimorphism;
use Math::Category::Impl::SubroutineMorphism;
use Math::Category::Impl::HomBifunctor;

my $length = Math::Category::Impl::SubroutineMorphism->new_with_sub( sub {
    return scalar @_;
} );

my $functor = Math::Category::Impl::HomBifunctor->new;
my $cps_length = $functor->apply(
	Math::Category::Impl::Bimorphism->new(
		morphism1 => Math::Category::Impl::OppositeMorphism->new(
			morphism => $length,
		),
		morphism2 => $Math::Category::Impl::SubroutineMorphism::ID,
	)
);

my @ret = $cps_length->subroutine->(
    Math::Category::Impl::SubroutineMorphism->new_with_sub( sub {
        return ('') x $_[0];
    } )
)->subroutine->('a', 'b', 'c');

is_deeply \@ret, ['', '', ''];
