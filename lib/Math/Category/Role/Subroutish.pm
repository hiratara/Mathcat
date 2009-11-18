package Math::Category::Role::Subroutish;
use Moose::Role;
use Math::Category::Util::Subroutine;

has impl => (
	is       => 'ro',
	isa      => 'Math::Category::Util::Subroutine',
	required => 1
);

around BUILDARGS => sub {
	my $super = shift;
	my $class = shift;
	my ( $impl ) = @_;
	return $class->$super( impl => wrap $impl );
};

no  Moose::Role;
1;
