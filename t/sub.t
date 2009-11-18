use strict;
use warnings;
use Test::More tests => 7;

BEGIN{ use_ok 'Math::Category::Util::Subroutine'; }


# TEST 1: one argument subroutines
{
    my $sub1 = wrap sub { $_[0] + 1 };
    my $sub2 = wrap sub { $_[0] * 2 };
    my $sub3   = $sub2 . $sub1;

    is $sub3->(1) ,  4;
    is $sub3->(5) , 12;
    is $sub3->(10), 22;
}


# TEST 2: void subroutines
{
    my $buffer;
    my $sub1 = wrap sub { $buffer .= 'hello'; };
    my $sub2 = wrap sub { $buffer .= 'world'; };
    my $sub3 = $sub2 . $sub1;

    is $sub3->(), 'helloworld';
}


# TEST 3: multi arguments
{
    my $sub1 = wrap sub { reverse @_ };
    my $sub2 = wrap sub { $_[0] };
    my $sub3 = wrap sub { ('x') x $_[0] };
    my $sub4 = $sub3 . $sub2 . $sub1;

    is_deeply [ $sub4->( qw(4 6 8) ) ], [ qw(x x x x x x x x) ];
}


# TEST 4: 1000 subroutines
{
    my $sub = wrap sub { $_[0] + 1, $_[1] + 2 };
    my $sub1000 = $sub;
    $sub1000 .= $sub for 2 .. 1000;

    is_deeply [ $sub1000->(0, 0) ], [1000, 2000];
}
