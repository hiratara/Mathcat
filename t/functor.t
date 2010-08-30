use strict;
use warnings;
use Test::More tests => 3;
use Mathcat::Morphism::Simple;

BEGIN { use_ok 'Mathcat::Functor'; };

my $id = functor { $_[0]; };
my $morph12 = simple_morph '1' => '2';

my $morph = $id->($morph12);
is $morph->source->from, '1';
is $morph->target->from, '2';
