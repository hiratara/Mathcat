package Mathcat::Example::CPSTransformation;
use strict;
use warnings;
use Mathcat::Morph::Op qw/op/;
use Mathcat::Morph::Sub;
use Mathcat::Funct::Impls qw($YONEDA_EMBEDDING);

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

    return sub {
        my ($cont, @params) = @_;

        # Wrap as morphism of Sets
        # ( Disabled prototype check )
        my $cont_morph = &sub_morph( $cont );

        # Get component of target of $cont.
        my $component = $fun_morph->( $cont_morph->target );

        # Get CPS tarnsformed subroutine
        my $cps_transformed = $component->( $cont_morph );

        # Apply arguments
        return $cps_transformed->(@params);
    };
}


1;
