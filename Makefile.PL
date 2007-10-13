use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'Tk::FlatCheckbox',
    VERSION_FROM      => 'lib/Tk/FlatCheckbox.pm',
    PREREQ_PM         => { Tk => 0 },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Tk/FlatCheckbox.pm',
       AUTHOR         => 'Slaven Rezic <srezic@cpan.org>') : ()),
);

sub MY::postamble {
    my $postamble = '';

    if (defined $ENV{USER} && $ENV{USER} eq 'eserte' && $^O =~ /bsd/i && -f "../../perl.release.mk") {
	$postamble .= <<'EOF';

.include "../../perl.release.mk"
.include "../../perl.cvs.mk"

EOF
    }

    $postamble;
}
