package Math::Category::Impl::AnyNaturalTransformation;
use Moose;
our $VERSION = '0.01';
extends 'Math::Category::NaturalTransformation';

has impl => ( is => 'ro', isa => 'CodeRef', required => 1 );

around BUILDARGS => sub {
	my $super = shift;
	my $class = shift;
	my ( $impl ) = @_;
	return $class->$super( impl => $impl );
};

override component => sub {
	my $self = shift;
	return $self->impl->(@_);
};

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
