use strict;
use Test::More tests => 2;
use Mathcat::Morph::Simple;
use Mathcat::Morph::Op qw/op/;
use Mathcat::Morph::Bi;
use Mathcat::Morph::Sub;
use Mathcat::Funct::Impls qw($HOM_BIFUNCTOR);

my $morph12 = simple_morph '1' => '2';
my $morph23 = simple_morph '2' => '3';
my $morph34 = simple_morph '3' => '4';
# $morph41 need not to instantiate though it's existed in this category.

my $sub_morph = $HOM_BIFUNCTOR->( bi_morph +(op $morph12), $morph34 );

# hom-functor made the subroutine which composes morphisms.
# Concretely, morph34 . morph23 . morph12 => morph14
my $morph41 = $sub_morph->($morph23);

is $morph41->source->from, '1';
is $morph41->target->from, '4';
