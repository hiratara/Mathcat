package Math::Category::Impl::AnyFunctor;
use Moose;

extends 'Math::Category::Functor';
with 'Math::Category::Role::Subroutish';

override apply => sub {
	my $self = shift;
	return $self->impl->( @_ );
};

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
