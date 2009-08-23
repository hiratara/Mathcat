package Math::Category::Impl::HomBifunctor;
use Moose;
use Math::Category::Impl::OppositeMorphism;
use Math::Category::Impl::Bimorphism;
use Math::Category::Impl::SubroutineMorphism;
our $VERSION = '0.01';

extends 'Math::Category::Skel::Functor';

# A mapping of morphisms.
sub apply {
	my $self = shift;
	my ($bimorphism) = @_;
	# morphism1 in the opposite category
	my $morph1 = $bimorphism->morphism1->morphism;
	my $morph2 = $bimorphism->morphism2;

	return Math::Category::Impl::SubroutineMorphism->new_with_sub( sub {
		my $morph = shift;
		return $morph2 . $morph . $morph1;
	} );
}

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
__END__

=head1 NAME

Math::Category::Impl::HomBifunctor - Implementation of C(-,-)

=head1 SYNOPSIS

  use Math::Category::Impl::HomBifunctor;

=head1 DESCRIPTION

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
