use strict;
use warnings;
use Test::More tests => 2;
use Mathcat::Morph::Simple;
use Mathcat::Funct;

my $funct1 = functor {
	my $simple_morph = shift;

	return simple_morph( $simple_morph->from + 1, $simple_morph->to + 1);
};
my $funct2 = functor {
	my $simple_morph = shift;
	return simple_morph($simple_morph->from * 2, $simple_morph->to - 2);
};

my $funct3 = $funct2 . $funct1;

my $morph = $funct3->( simple_morph 1 => 2 );
is $morph->from, 4;
is $morph->to  , 1;
