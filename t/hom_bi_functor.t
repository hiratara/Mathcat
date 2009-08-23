use strict;
use Test::More tests => 3;
use Math::Category::Impl::SimpleMorphism;
use Math::Category::Impl::OppositeMorphism;
use Math::Category::Impl::Bimorphism;
use Math::Category::Impl::SubroutineMorphism;

my $HOM = 'Math::Category::Impl::HomBifunctor';
use_ok $HOM;

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

my $functor = $HOM->new;
my $sub_morph = $functor->apply(
	Math::Category::Impl::Bimorphism->new(
		morphism1 => Math::Category::Impl::OppositeMorphism->new(
			morphism => $morph12,
		),
		morphism2 => $morph34,
	)
);

# hom-functor made the subroutine which composes morphisms.
# Concretely, morph34 . morph23 . morph12 => morph14
my $morph41 = $sub_morph->subroutine->($morph23);

is $morph41->source->source_object, '1';
is $morph41->target->source_object, '4';
