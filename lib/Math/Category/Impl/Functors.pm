package Math::Category::Impl::Functors;
use Math::Category::Impl::AnyFunctor;
use Math::Category::Impl::SubroutineMorphism;
use base Exporter::;
our @EXPORT_OK = qw($HOM_BIFUNCTOR);

our $HOM_BIFUNCTOR = Math::Category::Impl::AnyFunctor->new( sub {
	my ($bimorphism) = @_;
	# morphism1 in the opposite category
	my $morph1 = $bimorphism->morphism1->morphism;
	my $morph2 = $bimorphism->morphism2;

	return Math::Category::Impl::SubroutineMorphism->new_with_sub( sub {
		my $morph = shift;
		return $morph2 . $morph . $morph1;
	} );
} );

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
