package Math::Category::Morphism::Opposite;
use Moose;
use Sub::Exporter;
our $VERSION = '0.01';

extends 'Math::Category::Morphism';

has morphism   => (
	isa      => 'Math::Category::Morphism',
	is       => 'ro',
	required => 1,
);

my @export = qw/opposite/;
Sub::Exporter::setup_exporter( { 
	exports => [ @export, 'op' ],
	groups  => { default => \@export, }, 
} );

sub opposite ($){
	my $morph = shift;

	if( $morph->isa( __PACKAGE__ ) ){
		return $morph->morphism;
	}else{
		return __PACKAGE__->new( morphism => $morph );
	}
}

# short cut
*op = \&opposite;

sub source      { 
	my $self = shift;
	return opposite $self->morphism->target;
}
sub target      { 
	my $self = shift;
	return opposite $self->morphism->source;
}
sub composition {
	my $self     = shift;
	my $morphism = shift;
	return opposite( $morphism->morphism . $self->morphism ); 
}

__PACKAGE__->meta->make_immutable;
no  Moose;
1;
