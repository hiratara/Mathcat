package Math::Category::Impl::NaturalTransformationFactory;
use Moose;
our $VERSION = '0.01';
extends 'Math::Category::Skel::NaturalTransformation';

has component_sub => (
	isa      => 'CodeRef',
	is       => 'ro',
	required => 1,
);

# Overrided
sub component {
	my $self = shift;
	return $self->component_sub->(@_);
};

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
