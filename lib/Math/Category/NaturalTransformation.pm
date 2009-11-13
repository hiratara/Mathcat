package Math::Category::NaturalTransformation;
use Moose;
our $VERSION = '0.01';

# my $morph = $nt->component( $id )
sub component { die "the morphism for id arrow."; }

__PACKAGE__->meta->make_immutable;
no  Moose;

1;
__END__

=head1 NAME

Math::Category::NaturalTransformation - Abstract class for natural 
transformation.

=head1 SYNOPSIS

  use Math::Category::NaturalTransformation;

=head1 DESCRIPTION

Math::Category::NaturalTransformation is an abstract class for natural
tarnsformation.
You should implement methods of this class to implement a natural
tarnsformation.

=head1 AUTHOR

hiratara E<lt>hira.tara@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
