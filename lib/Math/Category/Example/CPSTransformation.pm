package Math::Category::Example::CPSTransformation;
use strict;
use warnings;
use Math::Category::Impl::OppositeMorphism qw/op/;
use Math::Category::Impl::SubroutineMorphism;
use Math::Category::Impl::Functors qw($YONEDA_EMBEDDING);

use Sub::Exporter -setup => {
    exports => [ qw(cps_transformation) ],
};

# The sample of CPS transformation.
sub cps_transformation {
    my $f = shift;

    # Wrap as morphism of Sets^op
    my $morph = op &sub_morph( $f );  # Disabled prototype check

    # Get natural transformation corresponded to $f.
    my $fun_morph = $YONEDA_EMBEDDING->( $morph );
    my $nat = $fun_morph->natural_transformation;

    return sub {
        my ($cont, @params) = @_;

        # Wrap as morphism of Sets
        # ( Disabled prototype check )
        my $cont_morph = &sub_morph( $cont );

        # Get component of target of $cont.
        my $component = $nat->( $cont_morph->target );

        # Get CPS tarnsformed subroutine
        my $cps_transformed = $component->( $cont_morph );

        # Apply arguments
        return $cps_transformed->(@params);
    };
}


1;
