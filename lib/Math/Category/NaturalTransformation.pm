package Math::Category::NaturalTransformation;
use Moose;
use Sub::Exporter;

BEGIN{ sub component; } # XXX Because of mutual dependencies.
use Math::Category::Impl::AnyNaturalTransformation qw/nat/;
our $VERSION = '0.01';

use overload '&{}' => sub { my $s = shift; sub { $s->component(@_); }; },
             '.'   => "composition";

my @export = qw/nat_funct funct_nat/;
Sub::Exporter::setup_exporter( { 
	exports => \@export,
	groups  => { default => \@export, }, 
} );

# my $morph = $nt->component( $id )
sub component { die "the morphism for id arrow."; }

sub composition {
	my $self = shift;
	my ( $nat ) = @_;

	return nat {
		my $id = shift;
		return $self->( $id ) . $nat->( $id );
	};
}

# A composition nat of a nat and a functor.
sub nat_funct($$){
	my ($nat, $funct) = @_;
	return nat {
		my $id = shift;
		return $nat->( $funct->($id) );
	};
}

# A composition nat of a functor and a nat.
sub funct_nat($$){
	my ($funct, $nat) = @_;
	return nat {
		my $id = shift;
		return $funct->( $nat->( $id ) );
	};
}

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
__END__

=head1 NAME

Math::Category::NaturalTransformation - Abstract class for natural 
transformation.

=head1 SYNOPSIS

  use Math::Category::NaturalTransformation;

=head1 DESCRIPTION

Math::Category::NaturalTransformation is an abstract class for natural
tarnsformation.
You should implement methods of this class to implement a natural
tarnsformation.

=head1 AUTHOR

hiratara E<lt>hira.tara@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
