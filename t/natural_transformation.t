use strict;
use warnings;
use Mathcat::Morphism::Subroutine;
use Test::More tests => 2;

BEGIN { use_ok 'Mathcat::NaturalTransformation', qw/nat/; };

my $nt = nat {
    my $id = shift;
    return $id;
};

# natural transformation as id of category of functors
my $comp = $nt->( $Mathcat::Morphism::Subroutine::ID );
is $comp->('hoge'), 'hoge';
