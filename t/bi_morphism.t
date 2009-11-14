use strict;
use Test::More tests => 10;
use Math::Category::Impl::SimpleMorphism;
use Math::Category::Impl::SubroutineMorphism;

BEGIN { use_ok 'Math::Category::Impl::Bimorphism'; };

# TEST 1: source and target
{
    my $morph = bi_morph(
        Math::Category::Impl::SimpleMorphism->new(
            source_object => '1',
            target_object => '2',
        ), 
        sub_morph { $_[0] + 10 },
    );
    # Check the source.
    is $morph->source->morph1->source_object,  '1';
    is $morph->source->morph1->target_object,  '1';
    is $morph->source->morph2->(20), 20;  # id

    # Check the target.
    is $morph->target->morph1->source_object,  '2';
    is $morph->target->morph1->target_object,  '2';
    is $morph->target->morph2->(30), 30;  # id
}


# TEST 2: composition
{
    my $morph1 = bi_morph( 
        sub_morph { $_[0] + 10 },
        Math::Category::Impl::SimpleMorphism->new(
            source_object => '3',
            target_object => '4',
        ), 
    );
    my $morph2 = bi_morph( 
        sub_morph { $_[0] x 2 },
        Math::Category::Impl::SimpleMorphism->new(
            source_object => '4',
            target_object => '5',
        ), 
    );
    my $morph3 = $morph2 . $morph1;
    is $morph3->morph1->(1), '1111';
    is $morph3->morph2->source_object  ,    '3';
    is $morph3->morph2->target_object  ,    '5';
}
