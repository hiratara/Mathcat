package Math::Category::Monad::Sugars;
use strict;
use warnings;
use Exporter qw/import/;
use Coro;
use Coro::Channel;
use Math::Category::Monad::Maybe;
our @EXPORT = qw/do_expression coro/;

our $CORO;     # XXX 暫定でグローバル
our $CHAN_IN;  # XXX 暫定でグローバル
our $CHAN_OUT; # XXX 暫定でグローバル
sub do_expression(&){
	my $code = shift;

	return sub {
		my @args = @_;

		$CHAN_IN  = Coro::Channel->new;
		$CHAN_OUT = Coro::Channel->new;
		$CORO = async {
			my $ret = $code->(@args);
			$CHAN_IN->shutdown;
			return $ret;
		};

		my $do_next = 1;
		my $ret;
		while($do_next and my $event = $CHAN_IN->get ){
			my $monad = $event->{monad};
			$do_next = 0;
			$ret = eval_maybe(maybe_kleisli { 
				$CHAN_OUT->put($_[0]);
				$do_next = 1;
			} . maybe_kleisli { $monad });
		}
		return $ret unless $do_next;
		return $CORO->join;
	};
}

sub coro($){
	my $monad = shift;
	$CHAN_IN->put({monad => $monad});
	return $CHAN_OUT->get;
}

1;
