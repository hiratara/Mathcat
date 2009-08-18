use strict;
use Test::More tests => 7;

# for shortcut
my $MORPHISM = 'Math::Category::Impl::SubroutineMorphism';

use_ok $MORPHISM;

# TEST 1: one argument subroutines
{
    my $morph1 = $MORPHISM->new_with_sub( sub {
        return $_[0] + 1;
    } );
    my $morph2 = $MORPHISM->new_with_sub( sub {
        return $_[0] * 2;
    } );
    my $sub3   = ($morph2 . $morph1)->subroutine;

    is $sub3->(1) ,  4;
    is $sub3->(5) , 12;
    is $sub3->(10), 22;
}


# TEST 2: void subroutines
{
    my $buffer;
    my $morph1 = $MORPHISM->new_with_sub( sub {
        $buffer .= 'hello';
    } );
    my $morph2 = $MORPHISM->new_with_sub( sub {
        $buffer .= 'world';
    } );
    my $sub3   = ($morph2 . $morph1)->subroutine;

    is $sub3->(), 'helloworld';
}


# TEST 3: multi arguments
{
    my $morph1 = $MORPHISM->new_with_sub( sub {
        return reverse @_;
    } );
    my $morph2 = $MORPHISM->new_with_sub( sub {
        return shift;
    } );
    my $morph3 = $MORPHISM->new_with_sub( sub {
        return ('x') x $_[0];
    } );
    my $sub4   = ($morph3 . $morph2 . $morph1)->subroutine;

    is_deeply [ $sub4->( qw(4 6 8) ) ], [ qw(x x x x x x x x) ];
}


# TEST 4: 1000 subroutines
{
    my $morph = $MORPHISM->new_with_sub( sub {
        return $_[0] + 1, $_[1] + 2;
    } );
    my $morph1000 = $morph;
    $morph1000 .= $morph for 2 .. 1000;

    is_deeply [ $morph1000->subroutine->(0, 0) ], [1000, 2000];
}
