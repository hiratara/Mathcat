use strict;
use warnings;
use Test::More tests => 4;
use Mathcat::Morph::Simple;
use Mathcat::Funct;
use Mathcat::Nat qw/nat nat_funct funct_nat/;

my $funct = functor {
	my $simple_morph = shift;

	return simple_morph( $simple_morph->from + 1, $simple_morph->to + 1);
};
my $nat = nat {
	my $id = shift;
	return simple_morph($id->from => $id->from + 1);
};

my $nat1 = nat_funct $nat  , $funct;
my $nat2 = funct_nat $funct, $nat  ;

is $nat1->( simple_morph '1' => '1' )->from, '2';
is $nat1->( simple_morph '1' => '1' )->to  , '3';
is $nat2->( simple_morph '2' => '2' )->from, '3';
is $nat2->( simple_morph '2' => '2' )->to  , '4';
