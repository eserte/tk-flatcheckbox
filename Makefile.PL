use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'Tk::FlatCheckbox',
    VERSION           => '0.08',
    PREREQ_PM         => { Tk => 0 },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Tk/FlatCheckbox.pm',
       AUTHOR         => 'Slaven Rezic <srezic@cpan.org>') : ()),
);

sub MY::postamble {
    my $postamble = '';

    if (UNIVERSAL::can('MY', "oneliner")) {
	my($demo1, $demo2);
	if (eval { require File::Spec; 1; }) {
	    $demo1 = File::Spec->catfile(qw(t Tk-FlatCheckbox.t));
	    $demo2 = File::Spec->catfile(qw(t Tk-FlatRadiobutton.t));
	} else {
	    $demo1 = "t/Tk-FlatCheckbox.t";
	    $demo2 = "t/Tk-FlatRadiobutton.t";
	}
	my $demo_oneliner = MY->oneliner(q{$$ENV{BATCH}=0; system("$$^X -Mblib } . $demo1 .q{"); system("$$^X -Mblib } . $demo2 . q{")});
	$postamble = <<EOF;
demo :: pure_all
	$demo_oneliner

EOF
    } elsif ($^O ne "MSWin32") {
	$postamble = <<'EOF';
demo :: pure_all
	env BATCH=0 ${MAKE} test

EOF
    }

    if (defined $ENV{USER} && $ENV{USER} eq 'eserte' && $^O =~ /bsd/i && -f "../../perl.release.mk") {
	$postamble .= <<'EOF';

.include "../../perl.release.mk"
.include "../../perl.cvs.mk"

EOF
    }

    $postamble;
}
