package Mathcat::Role::Subroutish;
use Any::Moose 'Role';
use Mathcat::Util::Sub;

has impl => (
	is       => 'ro',
	isa      => 'Mathcat::Util::Sub',
	required => 1
);

around BUILDARGS => sub {
	my $super = shift;
	my $class = shift;
	my ( $impl ) = @_;
	return $class->$super( impl => wrap $impl );
};

no  Any::Moose 'Role';
1;
