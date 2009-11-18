package Math::Category::Morphism::Bimorphism;
use Moose;
use Sub::Exporter;
our $VERSION = '0.01';

extends 'Math::Category::Morphism';

has morphism1   => (
	isa      => 'Math::Category::Morphism',
	is       => 'ro',
	required => 1,
);

has morphism2   => (
	isa      => 'Math::Category::Morphism',
	is       => 'ro',
	required => 1,
);

# shortcut
*morph1 = \&morphism1;
*morph2 = \&morphism2;

my @export = qw/bi_morph/;
Sub::Exporter::setup_exporter( { 
	exports => \@export,
	groups  => { default => \@export, }, 
} );

sub bi_morph ($$){
	__PACKAGE__->new( morphism1 => $_[0], morphism2 => $_[1], );
}

sub source      { 
	my $self = shift;
	return bi_morph $self->morph1->source, $self->morph2->source;
}
sub target      {
	my $self = shift;
	return bi_morph $self->morph1->target, $self->morph2->target;
}
sub composition {
	my $self     = shift;
	my $morphism = shift;
	return bi_morph( 
		$self->morph1 . $morphism->morph1, 
		$self->morph2 . $morphism->morph2, 
	);
}

__PACKAGE__->meta->make_immutable;
no  Moose;
1;
