use strict;
use warnings;
use Test::More tests => 3;
use Math::Category::Impl::SimpleMorphism;

BEGIN { use_ok 'Math::Category::Impl::AnyFunctor'; };

my $id = functor { $_[0]; };
my $morph12 = Math::Category::Impl::SimpleMorphism->new(
    source_object => '1',
    target_object => '2',
);

my $morph = $id->($morph12);
is $morph->source->source_object, '1';
is $morph->target->source_object, '2';
