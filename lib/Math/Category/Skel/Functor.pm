package Math::Category::Skel::Functor;
use Moose;
our $VERSION = '0.01';

sub apply { die "a mapping of morphisms."; }

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
__END__

=head1 NAME

Math::Category::Skel::Functor - Abstract class for functor.

=head1 SYNOPSIS

  use Math::Category::Skel::Functor;

=head1 DESCRIPTION

Math::Category::Skel::Functor is an abstract class for functor.
You should implement methods of this class to implement a functor.

=head1 AUTHOR

hiratara E<lt>hira.tara@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
