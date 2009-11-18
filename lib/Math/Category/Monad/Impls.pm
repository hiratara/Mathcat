package Math::Category::Monad::Impls;
use Moose;
use Math::Category::Functor;
use Math::Category::NaturalTransformation qw/nat/;
use Math::Category::Monad;
use Math::Category::Morphism::Subroutine;
use base Exporter::;
our $VERSION = '0.01';

our @EXPORT_OK = qw/$LIST_MONAD/;


our $LIST_MONAD = Math::Category::Monad->new(
	functor => functor {
		my $sub_morph = shift;
		return sub_morph { map { [ $sub_morph->( @$_ ) ] } @_ };
	},

	# All components were same for any ids in the category of subroutines.
	eta     => nat { sub_morph { [ @_ ] } },
	mu      => nat { sub_morph { map { @$_ } @_ } },
);


__PACKAGE__->meta->make_immutable;
no  Moose;
1;
