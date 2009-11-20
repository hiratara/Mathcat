package Math::Category::Functor::Impls;
use strict;
use warnings;
use Math::Category::Functor;
use Math::Category::NaturalTransformation qw/nat/;
use Math::Category::Morphism::Functor;
use Math::Category::Morphism::Subroutine;
use Math::Category::Morphism::Bimorphism;
use Math::Category::Morphism::Opposite qw/op/;
use base Exporter::;
our @EXPORT_OK = qw(
	$HOM_BIFUNCTOR $YONEDA_EMBEDDING $LIST_FUNCTOR $STATE_FUNCTOR 
);

our $HOM_BIFUNCTOR = functor {
	my ($bimorphism) = @_;
	# morphism1 is one of the C^op.
	my $morph1 = op $bimorphism->morph1;
	my $morph2 = $bimorphism->morph2;

	return sub_morph { $morph2 . $_[0] . $morph1 };
};


our $YONEDA_EMBEDDING = functor {
	my ($op_morph) = @_;

	return functor_morph( nat {
		my $id = shift;

		# The component of $id is Hom( $po_morph, $id ).
		return $HOM_BIFUNCTOR->( bi_morph $op_morph, $id );
	} );
};


our $LIST_FUNCTOR = functor {
	my $sub_morph = shift;
	return sub_morph { map { [ $sub_morph->( @$_ ) ] } @_ };
};


our $STATE_FUNCTOR = functor {
	my $sub_morph = shift;
	return sub_morph {
		my $state_val = shift;  # $state_val->(state) => [values], [state]
		return sub {
			my ($val, $state) = $state_val->( @_ );
			return [ $sub_morph->( @$val ) ], $state;
		}
	};
};


1;


__END__

=head1 NAME

Math::Category::Functor::Impls - Functor implementations.

=head1 SYNOPSIS

  use Math::Category::Functor::Impls qw($HOM_BIFUNCTOR);

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
