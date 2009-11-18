use strict;
use warnings;
use Math::Category::Impl::SubroutineMorphism;
use Test::More tests => 2;

BEGIN { use_ok 'Math::Category::NaturalTransformation', qw/nat/; };

my $nt = nat {
    my $id = shift;
    return $id;
};

# natural transformation as id of category of functors
my $comp = $nt->( $Math::Category::Impl::SubroutineMorphism::ID );
is $comp->('hoge'), 'hoge';
