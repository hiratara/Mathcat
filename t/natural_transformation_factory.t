use strict;
use warnings;
use Math::Category::Impl::SubroutineMorphism;
use Test::More tests => 2;

my $NTF = 'Math::Category::Impl::NaturalTransformationFactory';
use_ok $NTF;

my $nt = $NTF->new( component_sub => sub {
    my $id = shift;
    return $id;
});

# natural transformation as id of category of functors
my $comp = $nt->component( $Math::Category::Impl::SubroutineMorphism::ID );
is $comp->subroutine->('hoge'), 'hoge';
