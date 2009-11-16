package Math::Category::Functor;
use Moose;
# XXX Because of mutual dependencies.
BEGIN { sub apply; } use Math::Category::Impl::AnyFunctor;
our $VERSION = '0.01';

# Definition of composition operator
use overload '&{}' => sub { my $s = shift; sub { $s->apply(@_); }; },
             '.'   => "composition";

sub apply { die "a mapping of morphisms."; }

sub composition {
	my $self = shift;
	my ( $funct ) = @_;

	# XXX Shouldn't use the recursive implementation.
	return functor {
		my $morph = shift;;
		return $self->( $funct->( $morph ) );
	};
}


__PACKAGE__->meta->make_immutable;
no  Moose;

1;
__END__

=head1 NAME

Math::Category::Functor - Abstract class for functor.

=head1 SYNOPSIS

  use Math::Category::Functor;

=head1 DESCRIPTION

Math::Category::Functor is an abstract class for functor.
You should implement methods of this class to implement a functor.

=head1 AUTHOR

hiratara E<lt>hira.tara@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
