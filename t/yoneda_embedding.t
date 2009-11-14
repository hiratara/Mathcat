use strict;
use Test::More tests => 2;
use Math::Category::Impl::SimpleMorphism;
use Math::Category::Impl::OppositeMorphism qw(op);
use Math::Category::Impl::Functors qw($YONEDA_EMBEDDING);

my $morph21 = simple_morph '2' => '1';
my $morph13 = simple_morph '1' => '3';

# Apply Yoneda functor.
my $func_morph = $YONEDA_EMBEDDING->( op $morph21 );

# Actually it's a natural transformation.
my $nat       = $func_morph->natural_transformation;

# Get component morphism corresponding to an object.
my $sub_morph = $nat->( $morph13->target );

# The morphism is C($morph21, $id) in Sets. (i.e. function)
my $morph23 = $sub_morph->( $morph13 );

is $morph23->source->from, '2';
is $morph23->target->to  , '3';
