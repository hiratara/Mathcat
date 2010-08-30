package Mathcat::Role::Subroutish;
use Any::Moose 'Role';
use Mathcat::Util::Subroutine;

has impl => (
	is       => 'ro',
	isa      => 'Mathcat::Util::Subroutine',
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
