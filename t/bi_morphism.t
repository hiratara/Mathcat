use strict;
use Test::More tests => 10;
use Mathcat::Morph::Simple;
use Mathcat::Morph::Sub;

BEGIN { use_ok 'Mathcat::Morph::Bi'; };

# TEST 1: source and target
{
    my $morph = bi_morph simple_morph('1' => '2'), sub_morph { $_[0] + 10 };

    # Check the source.
    is $morph->source->morph1->from,  '1';
    is $morph->source->morph1->to  ,  '1';
    is $morph->source->morph2->(20), 20;  # id

    # Check the target.
    is $morph->target->morph1->from,  '2';
    is $morph->target->morph1->to  ,  '2';
    is $morph->target->morph2->(30), 30;  # id
}


# TEST 2: composition
{
    my $morph1 = bi_morph sub_morph { $_[0] + 10 }, simple_morph('3' => '4');
    my $morph2 = bi_morph sub_morph { $_[0] x 2  }, simple_morph('4' => '5');
    my $morph3 = $morph2 . $morph1;

    is $morph3->morph1->(1), '1111';
    is $morph3->morph2->from, '3';
    is $morph3->morph2->to  , '5';
}
