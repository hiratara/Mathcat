use strict;
use warnings;
use Math::Category::Impl::SubroutineMorphism;
use Test::More tests => 2;

my $NTF = 'Math::Category::Impl::AnyNaturalTransformation';
use_ok $NTF;

my $nt = $NTF->new( sub {
    my $id = shift;
    return $id;
} );

# natural transformation as id of category of functors
my $comp = $nt->( $Math::Category::Impl::SubroutineMorphism::ID );
is $comp->subroutine->('hoge'), 'hoge';
