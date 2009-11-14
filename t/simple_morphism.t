use strict;
use Test::More tests => 7;

BEGIN { use_ok 'Math::Category::Impl::SimpleMorphism'; }

# TEST 1: source and target
{
    my $morph = simple_morph '1' => '2';

    is $morph->source->from,  '1';
    is $morph->source->to  ,  '1';
    is $morph->target->from,  '2';
    is $morph->target->to  ,  '2';
}


# TEST 2: composition
{
    my $morph1 = simple_morph '1' => '2';
    my $morph2 = simple_morph '2' => '3';

    my $morph3 = $morph2 . $morph1;
    is $morph3->from, '1';
    is $morph3->to  , '3';
}
