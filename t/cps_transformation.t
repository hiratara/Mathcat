use strict;
use Test::More tests => 2;
use Math::Category::Example::CPSTransformation qw(cps_transformation);

my $length      = sub { scalar @_;    };
my $empty_array = sub { ('') x $_[0]; };

# test of length
my $ret1 = $length->('a', 'b', 'c');
my @ret2 = $empty_array->( $ret1 );
is_deeply \@ret2, ['', '', ''];

# test of length_cps
my $length_cps = cps_transformation($length);
my @ret3 = $length_cps->($empty_array, 'a', 'b', 'c');
is_deeply \@ret3, ['', '', ''];
