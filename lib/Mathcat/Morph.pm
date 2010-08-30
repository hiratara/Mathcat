package Mathcat::Morph;
use Any::Moose;
our $VERSION = '0.01';

# Definition of composition operator
use overload '.' => "composition";

sub source      { die "Source identity of this morphism."; }
sub target      { die "Target identity of this morphism."; }
sub composition { die "Composit two morphisms."; }

__PACKAGE__->meta->make_immutable;
no  Any::Moose;

1;
__END__

=head1 NAME

Mathcat::Morph - Abstract class for morphism.

=head1 SYNOPSIS

  use Mathcat::Morph;

=head1 DESCRIPTION

Mathcat::Morph is an abstract class for morphism.
You should implement methods of this class to implement a morphism.

=head1 AUTHOR

hiratara E<lt>hira.tara@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
