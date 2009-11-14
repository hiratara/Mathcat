package Math::Category::Impl::AnyNaturalTransformation;
use Moose;
use Sub::Exporter;
our $VERSION = '0.01';

extends 'Math::Category::NaturalTransformation';
with 'Math::Category::Role::Subroutish';

my @export = qw/natural_transformation/;
Sub::Exporter::setup_exporter( { 
	exports => [ @export, 'nat' ],
	groups  => { default => \@export, }, 
} );

sub natural_transformation(&){
	__PACKAGE__->new( @_ );
}

# short cut
*nat = \&natural_transformation;

override component => sub {
	my $self = shift;
	return $self->impl->(@_);
};

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
