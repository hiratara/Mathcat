use strict;
use Test::More tests => 9;
use Math::Category::Impl::SimpleMorphism;

BEGIN { use_ok 'Math::Category::Impl::OppositeMorphism'; };

# TEST 1: source and target
{
    my $morph = opposite +(Math::Category::Impl::SimpleMorphism)->new(
        source_object => '1',
        target_object => '2',
    );
    is $morph->source->morphism->source_object,  '2';
    is $morph->source->morphism->target_object,  '2';
    is $morph->target->morphism->source_object,  '1';
    is $morph->target->morphism->target_object,  '1';
}


# TEST 2: composition
{
    my $morph1 = opposite 'Math::Category::Impl::SimpleMorphism'->new(
        source_object => '2',
        target_object => '3',
    );
    my $morph2 = opposite 'Math::Category::Impl::SimpleMorphism'->new(
        source_object => '1',
        target_object => '2',
    );

    my $morph3 = $morph2 . $morph1;
    is $morph3->source->morphism->source_object,  '3';
    is $morph3->source->morphism->target_object,  '3';
    is $morph3->target->morphism->source_object,  '1';
    is $morph3->target->morphism->target_object,  '1';
}
