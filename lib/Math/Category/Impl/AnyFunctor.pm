package Math::Category::Impl::AnyFunctor;
use Moose;
use Sub::Exporter;
our $VERSION = '0.01';

extends 'Math::Category::Functor';
with 'Math::Category::Role::Subroutish';

my @export = qw/functor/;
Sub::Exporter::setup_exporter( { 
	exports => \@export,
	groups  => { default => \@export, }, 
} );

sub functor(&){
	__PACKAGE__->new( @_ );
}

override apply => sub {
	my $self = shift;
	return $self->impl->( @_ );
};

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
