use strict;
use Test::More tests => 10;
use Math::Category::Impl::SimpleMorphism;
use Math::Category::Impl::SubroutineMorphism;

# for shortcut
my $BI = 'Math::Category::Impl::Bimorphism';

use_ok $BI;

# TEST 1: source and target
{
    my $morph = $BI->new( 
        morphism1 => Math::Category::Impl::SimpleMorphism->new(
            source_object => '1',
            target_object => '2',
        ), 
        morphism2 => sub_morph { $_[0] + 10 },
    );
    # Check the source.
    is $morph->source->morphism1->source_object,  '1';
    is $morph->source->morphism1->target_object,  '1';
    is $morph->source->morphism2->(20), 20;  # id

    # Check the target.
    is $morph->target->morphism1->source_object,  '2';
    is $morph->target->morphism1->target_object,  '2';
    is $morph->target->morphism2->(30), 30;  # id
}


# TEST 2: composition
{
    my $morph1 = $BI->new( 
        morphism1 => sub_morph { $_[0] + 10 },
        morphism2 => Math::Category::Impl::SimpleMorphism->new(
            source_object => '3',
            target_object => '4',
        ), 
    );
    my $morph2 = $BI->new( 
        morphism1 => sub_morph { $_[0] x 2 },
        morphism2 => Math::Category::Impl::SimpleMorphism->new(
            source_object => '4',
            target_object => '5',
        ), 
    );
    my $morph3 = $morph2 . $morph1;
    is $morph3->morphism1->(1), '1111';
    is $morph3->morphism2->source_object  ,    '3';
    is $morph3->morphism2->target_object  ,    '5';
}
