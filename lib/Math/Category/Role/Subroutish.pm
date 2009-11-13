package Math::Category::Role::Subroutish;
use Moose::Role;

has impl => ( is => 'ro', isa => 'CodeRef', required => 1 );

around BUILDARGS => sub {
	my $super = shift;
	my $class = shift;
	my ( $impl ) = @_;
	return $class->$super( impl => $impl );
};

no  Moose::Role;
1;
