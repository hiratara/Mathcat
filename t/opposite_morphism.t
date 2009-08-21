use strict;
use Test::More tests => 7;
use Math::Category::Impl::SimpleMorphism;

# for shortcut
my $OPPOSITE = 'Math::Category::Impl::OppositeMorphism';

use_ok $OPPOSITE;

# TEST 1: source and target
{
    my $morph = $OPPOSITE->new( 
        morphism => Math::Category::Impl::SimpleMorphism->new(
            source_object => '1',
            target_object => '2',
        ), 
    );
    is $morph->source->morphism->source_object,  '2';
    is $morph->source->morphism->target_object,  '2';
    is $morph->target->morphism->source_object,  '1';
    is $morph->target->morphism->target_object,  '1';
}


# TEST 2: composition
{
    my $morph1 = $OPPOSITE->new( 
        morphism => Math::Category::Impl::SimpleMorphism->new(
            source_object => '3',
            target_object => '2',
        ), 
    );
    my $morph2 = $OPPOSITE->new( 
        morphism => Math::Category::Impl::SimpleMorphism->new(
            source_object => '2',
            target_object => '1',
        ), 
    );

    my $morph3 = $morph2 . $morph1;
    is $morph3->morphism->source_object,  '3';
    is $morph3->morphism->target_object,  '1';
}
