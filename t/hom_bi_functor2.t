use strict;
use Test::More tests => 2;
use Math::Category::Impl::OppositeMorphism;
use Math::Category::Impl::Bimorphism;
use Math::Category::Impl::SubroutineMorphism;
use Math::Category::Impl::HomBifunctor;

# The sample of CPS transformation.
sub cps_transformation {
    my $f = shift;

    my $functor = Math::Category::Impl::HomBifunctor->new;
    my $morph = Math::Category::Impl::SubroutineMorphism->new_with_sub( $f );
    my $hom_morph = $functor->apply(
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

my $length      = sub { scalar @_;    };
my $empty_array = sub { ('') x $_[0]; };

# test of length
my $ret1 = $length->('a', 'b', 'c');
my @ret2 = $empty_array->( $ret1 );
is_deeply \@ret2, ['', '', ''];

# test of length_cps
my $length_cps = cps_transformation($length);
my @ret3 = $length_cps->($empty_array, 'a', 'b', 'c');
is_deeply \@ret3, ['', '', ''];
