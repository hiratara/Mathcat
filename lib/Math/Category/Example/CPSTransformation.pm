package Math::Category::Example::CPSTransformation;
use strict;
use warnings;
use Math::Category::Impl::OppositeMorphism;
use Math::Category::Impl::Bimorphism;
use Math::Category::Impl::SubroutineMorphism;
use Math::Category::Impl::Functors qw($YONEDA_EMBEDDING);

use Sub::Exporter -setup => {
    exports => [ qw(cps_transformation) ],
};

# The sample of CPS transformation.
sub cps_transformation {
    my $f = shift;

    # Wrap as morphism of Sets^op
    my $morph = Math::Category::Impl::OppositeMorphism->new(
        morphism => Math::Category::Impl::SubroutineMorphism->new_with_sub( 
            $f 
        ),
    );

    # Get natural transformation corresponded to $f.
    my $fun_morph = $YONEDA_EMBEDDING->( $morph );
    my $nat = $fun_morph->natural_transformation;

    return sub {
        my ($cont, @params) = @_;

        # Wrap as morphism of Sets
        my $cont_morph = Math::Category::Impl::SubroutineMorphism
                         ->new_with_sub( $cont );

        # Get component of target of $cont.
        my $component = $nat->( $cont_morph->target );
        my $sub       = $component->subroutine;

        # Get CPS tarnsformed subroutine
        my $cps_transformed = $sub->( $cont_morph )->subroutine;

        # Apply arguments
        return $cps_transformed->(@params);
    };
}


1;
