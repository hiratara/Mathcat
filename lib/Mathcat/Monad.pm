package Mathcat::Monad;
use Any::Moose;
our $VERSION = '0.01';

# Monad acts a functor.
use overload '&{}' => sub { my $s = shift; sub { $s->functor->(@_); }; };

# Endo-functor T
has functor => ( 
	is      => 'ro', 
	isa     => 'Mathcat::Funct', 
	required => 1 
);

# Identity : I -> T
has eta     => ( 
	is      => 'ro', 
	isa     => 'Mathcat::Nat', 
	required => 1 
);

# Associativity : TT -> T
has mu      => ( 
	is      => 'ro', 
	isa     => 'Mathcat::Nat', 
	required => 1 
);

__PACKAGE__->meta->make_immutable;
no  Any::Moose;

1;
