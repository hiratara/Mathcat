package Math::Category::Morphism::Subroutine;
use Moose;
use Sub::Exporter;
use overload '&{}' => sub { my $s = shift; sub { $s->subroutine->(@_); }; };
our $VERSION = '0.01';

extends 'Math::Category::Morphism';

has subroutines => (
	isa      => 'ArrayRef[CodeRef]',
	is       => 'ro',
	required => 1,
);

my @export = qw/sub_morph/;
Sub::Exporter::setup_exporter( { 
	exports => \@export,
	groups  => { default => \@export, }, 
} );

sub sub_morph(&){
	return __PACKAGE__->new_with_sub( @_ );
}

our $ID = sub_morph { @_ };

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

Math::Category::Morphism - Abstract class for morphism.

=head1 SYNOPSIS

  use Math::Category::Morphism;

=head1 DESCRIPTION

Math::Category::Morphism is an abstract class for morphism.
You should implement methods of this class to implement a morphism.

=head1 AUTHOR

hiratara E<lt>hira.tara@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
