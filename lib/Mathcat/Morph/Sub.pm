package Mathcat::Morph::Sub;
use Any::Moose;
use Sub::Exporter;

use overload '&{}' => sub { my $s = shift; sub { $s->call(@_); }; };

our $VERSION = '0.01';

extends 'Mathcat::Morph';
with 'Mathcat::Role::Subroutish';

my @export = qw/sub_morph/;
Sub::Exporter::setup_exporter( { 
	exports => \@export,
	groups  => { default => \@export, }, 
} );

sub sub_morph(&){
	return __PACKAGE__->new( $_[0] );
}

our $ID = sub_morph { @_ };

sub source      { return $ID; }
sub target      { return $ID; }
sub composition {
	my $self     = shift;
	my $morphism = shift;

	# avoid a prototype check
	return &sub_morph( $self->impl . $morphism->impl );
}

sub call {
	my $self = shift;
	return $self->impl->( @_ );
}

__PACKAGE__->meta->make_immutable;
no  Any::Moose;

1;
__END__

=head1 NAME

Mathcat::Morph - Abstract class for morphism.

=head1 SYNOPSIS

  use Mathcat::Morph;

=head1 DESCRIPTION

Mathcat::Morph is an abstract class for morphism.
You should implement methods of this class to implement a morphism.

=head1 AUTHOR

hiratara E<lt>hira.tara@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
