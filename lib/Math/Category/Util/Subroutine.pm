package Math::Category::Util::Subroutine;
use Moose;
use Sub::Exporter;
use overload '&{}' => sub { my $s = shift; sub { $s->subroutine->(@_); }; },
             '.'   => "composition";
our $VERSION = '0.01';

has subroutines => (
	isa      => 'ArrayRef[CodeRef]',
	is       => 'ro',
	required => 1,
);

my @export = qw/wrap/;
Sub::Exporter::setup_exporter( { 
	exports => \@export,
	groups  => { default => \@export, }, 
} );

sub wrap($){
	my $sub = shift;
	return $sub if UNIVERSAL::isa $sub, __PACKAGE__;
	return __PACKAGE__->new( subroutines => [ $sub ] );
}


sub composition {
	my $self     = shift;
	my $morphism = shift;
	return __PACKAGE__->new(
		subroutines => [ @{ $self->subroutines }, @{ $morphism->subroutines } ]
	);
}

sub subroutine {
	my $self = shift;

	# To apply subroutines from end to start.
	my @subs = reverse @{ $self->subroutines };
	return sub {
		my @cur_args = @_;
		@cur_args = $_->( @cur_args ) for @subs;
		return wantarray ? @cur_args : $cur_args[0];
	};
}

__PACKAGE__->meta->make_immutable;
no  Moose;
1;
