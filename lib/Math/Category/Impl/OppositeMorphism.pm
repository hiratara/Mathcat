package Math::Category::Impl::OppositeMorphism;
use Moose;
our $VERSION = '0.01';
extends 'Math::Category::Skel::Morphism';

has morphism   => (
	isa      => 'Math::Category::Skel::Morphism',
	is       => 'ro',
	required => 1,
);

sub source      { 
	my $self = shift;
	return __PACKAGE__->new( morphism => $self->morphism->target, );
}
sub target      { 
	my $self = shift;
	return __PACKAGE__->new( morphism => $self->morphism->source, );
}
sub composition {
	my $self     = shift;
	my $morphism = shift;
	return __PACKAGE__->new(
		morphism => $self->morphism . $morphism->morphism, 
	);
}

__PACKAGE__->meta->make_immutable;
no  Moose;
1;
