package Math::Category::Impl::SubroutineMorphism;
use Moose;
our $VERSION = '0.01';

extends 'Math::Category::Skel::Morphism';

has subroutines => (
	isa      => 'ArrayRef[CodeRef]',
	is       => 'ro',
	required => 1,
);

our $ID = sub { @_ };

sub new_with_sub {
	my $class = shift;
	my ($subroutine) = @_;
	return $class->new( subroutines => [ $subroutine ] );
}

sub source      { return $ID; }
sub target      { return $ID; }
sub composition {
	my $self     = shift;
	my $morphism = shift;
	return __PACKAGE__->new(
		subroutines => [ @{ $self->subroutines }, @{ $morphism->subroutines } ]
	);
}

sub subroutine {
	my $self = shift;

	# To apply subroutines from end to start.
	my @subs = reverse @{ $self->subroutines };
	return sub {
		my @cur_args = @_;
		@cur_args = $_->( @cur_args ) for @subs;
		return wantarray ? @cur_args : $cur_args[0];
	};
}

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
__END__

=head1 NAME

Math::Category::Skel::Morphism - Abstract class for morphism.

=head1 SYNOPSIS

  use Math::Category::Skel::Morphism;

=head1 DESCRIPTION

Math::Category::Skel::Morphism is an abstract class for morphism.
You should implement methods of this class to implement a morphism.

=head1 AUTHOR

hiratara E<lt>hira.tara@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
