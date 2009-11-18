use strict;
use Test::More tests => 17;
use Math::Category::Morphism::Simple;
use Math::Category::NaturalTransformation qw/nat/;

# for shortcut
BEGIN { use_ok 'Math::Category::Morphism::Functor'; }


# Source and targets
my $morph = functor_morph nat {
	my $id = shift;
	return {
		'1' => (simple_morph '4' => '5'),
		'2' => (simple_morph '4' => '6'),
		'3' => (simple_morph '4' => '7'),
	}->{ $id->from };
};

my $nat_id1 = $morph->source;
is $nat_id1->( simple_morph '1' => '1' )->from, '4';
is $nat_id1->( simple_morph '1' => '1' )->to  , '4';
is $nat_id1->( simple_morph '2' => '2' )->from, '4';
is $nat_id1->( simple_morph '2' => '2' )->to  , '4';
is $nat_id1->( simple_morph '3' => '3' )->from, '4';
is $nat_id1->( simple_morph '3' => '3' )->to  , '4';

my $nat_id2 = $morph->target;
is $nat_id2->( simple_morph '1' => '1' )->from, '5';
is $nat_id2->( simple_morph '1' => '1' )->to  , '5';
is $nat_id2->( simple_morph '2' => '2' )->from, '6';
is $nat_id2->( simple_morph '2' => '2' )->to  , '6';
is $nat_id2->( simple_morph '3' => '3' )->from, '7';
is $nat_id2->( simple_morph '3' => '3' )->to  , '7';


# Composition
my $morph1 = functor_morph nat {
	my $id = shift;
	return {
		'1' => (simple_morph '1' => '3'),
		'2' => (simple_morph '2' => '4'),
	}->{ $id->from };
};
my $morph2 = functor_morph nat {
	my $id = shift;
	return {
		'1' => (simple_morph '3' => '5'),
		'2' => (simple_morph '4' => '6'),
	}->{ $id->from };
};
my $morph3 = $morph2 . $morph1;

is $morph3->( simple_morph '1' => '1' )->from, '1';
is $morph3->( simple_morph '1' => '1' )->to  , '5';
is $morph3->( simple_morph '2' => '2' )->from, '2';
is $morph3->( simple_morph '2' => '2' )->to  , '6';
