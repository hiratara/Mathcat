package Math::Category::Example::CPSTransformation;
use strict;
use warnings;
use Math::Category::Impl::OppositeMorphism;
use Math::Category::Impl::Bimorphism;
use Math::Category::Impl::SubroutineMorphism;
use Math::Category::Impl::Functors qw($HOM_BIFUNCTOR);

use Sub::Exporter -setup => {
    exports => [ qw(cps_transformation) ],
};

# The sample of CPS transformation.
sub cps_transformation {
    my $f = shift;

    my $morph = Math::Category::Impl::SubroutineMorphism->new_with_sub( $f );
    my $hom_morph = $HOM_BIFUNCTOR->(
        Math::Category::Impl::Bimorphism->new(
            morphism1 => Math::Category::Impl::OppositeMorphism->new(
                morphism => $morph,
            ),
            morphism2 => $Math::Category::Impl::SubroutineMorphism::ID,
        )
    );

    return sub {
        my ($cont, @params) = @_;
        my $source_hom = 
               Math::Category::Impl::SubroutineMorphism->new_with_sub( $cont );
        my $target_hom = $hom_morph->subroutine->( $source_hom );

        return $target_hom->subroutine->( @params );
    };
}


1;
