use strict;
use warnings;
use Mathcat::Morph::Sub;
use Test::More tests => 2;

BEGIN { use_ok 'Mathcat::Nat', qw/nat/; };

my $nt = nat {
    my $id = shift;
    return $id;
};

# natural transformation as id of category of functors
my $comp = $nt->( $Mathcat::Morph::Sub::ID );
is $comp->('hoge'), 'hoge';
