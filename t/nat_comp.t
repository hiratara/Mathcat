use strict;
use Test::More tests => 4;
use Mathcat::Morph::Simple;
use Mathcat::Nat qw/nat/;

# Composition
my $nat1 = nat {
	my $id = shift;
	return {
		'1' => (simple_morph '1' => '3'),
		'2' => (simple_morph '2' => '4'),
	}->{ $id->from };
};

my $nat2 = nat {
	my $id = shift;
	return {
		'1' => (simple_morph '3' => '5'),
		'2' => (simple_morph '4' => '6'),
	}->{ $id->from };
};

my $nat3 = $nat2 . $nat1;
is $nat3->( simple_morph '1' => '1' )->from, '1';
is $nat3->( simple_morph '1' => '1' )->to  , '5';
is $nat3->( simple_morph '2' => '2' )->from, '2';
is $nat3->( simple_morph '2' => '2' )->to  , '6';
