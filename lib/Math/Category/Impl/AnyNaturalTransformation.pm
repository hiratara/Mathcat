package Math::Category::Impl::AnyNaturalTransformation;
use Moose;
our $VERSION = '0.01';
extends 'Math::Category::NaturalTransformation';
with 'Math::Category::Role::Subroutish';

override component => sub {
	my $self = shift;
	return $self->impl->(@_);
};

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
