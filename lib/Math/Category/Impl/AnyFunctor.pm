package Math::Category::Impl::AnyFunctor;
use Moose;

extends 'Math::Category::Functor';

has impl => ( is => 'ro', isa => 'CodeRef', required => 1 );

around BUILDARGS => sub {
	my $super = shift;
	my $class = shift;
	my ( $impl ) = @_;
	return $class->$super( impl => $impl );
};

override apply => sub {
	my $self = shift;
	return $self->impl->( @_ );
};

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
