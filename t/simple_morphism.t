use strict;
use Test::More tests => 7;

# for shortcut
my $SIMPLE = 'Math::Category::Impl::SimpleMorphism';

use_ok $SIMPLE;

# TEST 1: source and target
{
    my $morph = $SIMPLE->new(
        source_object => '1',
        target_object => '2',
    );

    is $morph->source->source_object,  '1';
    is $morph->source->target_object,  '1';
    is $morph->target->source_object,  '2';
    is $morph->target->target_object,  '2';
}


# TEST 2: composition
{
    my $morph1 = $SIMPLE->new(
        source_object => '1',
        target_object => '2',
    );
    my $morph2 = $SIMPLE->new(
        source_object => '2',
        target_object => '3',
    );

    my $morph3 = $morph2 . $morph1;
    is $morph3->source_object,  '1';
    is $morph3->target_object,  '3';
}
