use strict;
use Test::More tests => 9;
use Math::Category::Impl::SimpleMorphism;

BEGIN { use_ok 'Math::Category::Impl::OppositeMorphism', qw/op/; };

# TEST 1: source and target
{
    my $morph = op simple_morph '1' => '2';

    is op( $morph->source )->from,  '2';
    is op( $morph->source )->to  ,  '2';
    is op( $morph->target )->from,  '1';
    is op( $morph->target )->to  ,  '1';
}


# TEST 2: composition
{
    my $morph1 = op simple_morph '2' => '3';
    my $morph2 = op simple_morph '1' => '2';

    my $morph3 = $morph2 . $morph1;
    is op( $morph3->source )->from,  '3';
    is op( $morph3->source )->to  ,  '3';
    is op( $morph3->target )->from,  '1';
    is op( $morph3->target )->to  ,  '1';
}
