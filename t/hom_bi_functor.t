use strict;
use Test::More tests => 2;
use Math::Category::Impl::SimpleMorphism;
use Math::Category::Impl::OppositeMorphism qw/op/;
use Math::Category::Impl::Bimorphism;
use Math::Category::Impl::SubroutineMorphism;
use Math::Category::Impl::Functors qw($HOM_BIFUNCTOR);

my $morph12 = Math::Category::Impl::SimpleMorphism->new(
    source_object => '1',
    target_object => '2',
);
my $morph23 = Math::Category::Impl::SimpleMorphism->new(
    source_object => '2',
    target_object => '3',
);
my $morph34 = Math::Category::Impl::SimpleMorphism->new(
    source_object => '3',
    target_object => '4',
);
# $morph41 need not to instantiate though it's existed in this category.

my $sub_morph = $HOM_BIFUNCTOR->(
	Math::Category::Impl::Bimorphism->new(
		morphism1 => ( op $morph12 ),
		morphism2 => $morph34,
	)
);

# hom-functor made the subroutine which composes morphisms.
# Concretely, morph34 . morph23 . morph12 => morph14
my $morph41 = $sub_morph->($morph23);

is $morph41->source->source_object, '1';
is $morph41->target->source_object, '4';
