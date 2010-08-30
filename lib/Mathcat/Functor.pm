package Mathcat::Functor;
use Any::Moose;
use Sub::Exporter;

# Definition of composition operator
use overload '&{}' => sub { my $s = shift; sub { $s->apply(@_); }; },
             '.'   => "composition";

our $VERSION = '0.01';

with 'Mathcat::Role::Subroutish';

my @export = qw/functor/;
Sub::Exporter::setup_exporter( { 
	exports => \@export,
	groups  => { default => \@export, }, 
} );

sub functor(&){
	__PACKAGE__->new( @_ );
}

sub apply {
	my $self = shift;
	return $self->impl->( @_ );
};

sub composition {
	my $self = shift;
	my ( $funct ) = @_;

	# Avoid prototype checks.
	return &functor( $self->impl . $funct->impl );
}

__PACKAGE__->meta->make_immutable;
no  Any::Moose;

1;
__END__

=head1 NAME

Mathcat::Functor - Abstract class for functor.

=head1 SYNOPSIS

  use Mathcat::Functor;

=head1 DESCRIPTION

Mathcat::Functor is an abstract class for functor.
You should implement methods of this class to implement a functor.

=head1 AUTHOR

hiratara E<lt>hira.tara@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
