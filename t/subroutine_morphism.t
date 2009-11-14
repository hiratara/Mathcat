use strict;
use Test::More tests => 9;

BEGIN{ use_ok 'Math::Category::Impl::SubroutineMorphism'; }

# TEST 0: check the source and target
{
    my $morph = sub_morph { $_[0] + 100 };

    is $morph->source->(123), 123;  # source and target should be id func.
    is $morph->target->(765), 765;
}


# TEST 1: one argument subroutines
{
    my $morph1 = sub_morph { $_[0] + 1 };
    my $morph2 = sub_morph { $_[0] * 2 };
    my $morph3   = $morph2 . $morph1;

    is $morph3->(1) ,  4;
    is $morph3->(5) , 12;
    is $morph3->(10), 22;
}


# TEST 2: void subroutines
{
    my $buffer;
    my $morph1 = sub_morph { $buffer .= 'hello'; };
    my $morph2 = sub_morph { $buffer .= 'world'; };
    my $morph3 = $morph2 . $morph1;

    is $morph3->(), 'helloworld';
}


# TEST 3: multi arguments
{
    my $morph1 = sub_morph { reverse @_ };
    my $morph2 = sub_morph { $_[0] };
    my $morph3 = sub_morph { ('x') x $_[0] };
    my $morph4 = $morph3 . $morph2 . $morph1;

    is_deeply [ $morph4->( qw(4 6 8) ) ], [ qw(x x x x x x x x) ];
}


# TEST 4: 1000 subroutines
{
    my $morph = sub_morph { $_[0] + 1, $_[1] + 2 };
    my $morph1000 = $morph;
    $morph1000 .= $morph for 2 .. 1000;

    is_deeply [ $morph1000->(0, 0) ], [1000, 2000];
}
