package Math::Category::Impl::Functors;
use Math::Category::Impl::AnyFunctor;
use Math::Category::Impl::AnyNaturalTransformation;
use Math::Category::Impl::FunctorMorphism;
use Math::Category::Impl::SubroutineMorphism;
use Math::Category::Impl::Bimorphism;
use Math::Category::Impl::OppositeMorphism;
use base Exporter::;
our @EXPORT_OK = qw($HOM_BIFUNCTOR $YONEDA_EMBEDDING);

our $HOM_BIFUNCTOR = functor {
	my ($bimorphism) = @_;
	# morphism1 in the opposite category
	my $morph1 = $bimorphism->morphism1->morphism;
	my $morph2 = $bimorphism->morphism2;

	return sub_morph { $morph2 . $_[0] . $morph1 };
};


our $YONEDA_EMBEDDING = functor {
	my ($op_morph) = @_;

	return Math::Category::Impl::FunctorMorphism->new_with_nat(
		natural_transformation {
			my $id = shift;

			# The component of $id is Hom( $po_morph, $id ).
			return $HOM_BIFUNCTOR->(
				Math::Category::Impl::Bimorphism->new(
					morphism1 => $op_morph,
					morphism2 => $id,
				)
			);
		}, 
	);
};


1;


__END__

=head1 NAME

Math::Category::Impl::Functors - Functor implementations.

=head1 SYNOPSIS

  use Math::Category::Impl::Functors qw($HOM_BIFUNCTOR);

=head1 DESCRIPTION

=item $HOM_BIFUNCTOR

Math::Category::Impl::HomBifunctor is implementation of C(-,-) bifunctor.

C(-,-): C^op x C -> Sets

Strictly speaking, it's not to Sets but to the category of perl subroutines.
(via: SubroutineMorphism)

=head1 AUTHOR

hiratara E<lt>hira.tara@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
