package Math::Category::Monad;
use Moose;
our $VERSION = '0.01';

# Monad acts a functor.
use overload '&{}' => sub { my $s = shift; sub { $s->functor->(@_); }; };

# Endo-functor T
has functor => ( 
	is      => 'ro', 
	isa     => 'Math::Category::Functor', 
	required => 1 
);

# Identity : I -> T
has eta     => ( 
	is      => 'ro', 
	isa     => 'Math::Category::NaturalTransformation', 
	required => 1 
);

# Associativity : TT -> T
has mu      => ( 
	is      => 'ro', 
	isa     => 'Math::Category::NaturalTransformation', 
	required => 1 
);

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
