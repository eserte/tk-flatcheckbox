#!/usr/local/bin/perl -w
# -*- perl -*-

#
# $Id: Tk-FlatCheckbox.t,v 1.1 2007/10/13 21:39:39 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 1998,2004 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: eserte@cs.tu-berlin.de
# WWW:  http://user.cs.tu-berlin.de/~eserte/
#

use strict;

BEGIN {
    if (!eval q{
	use Test::More;
	use Tk;
	1;
    }) {
	print "1..0 # skip: no Test::More and/or Tk modules\n";
	exit;
    }
}

if (!defined $ENV{BATCH}) { $ENV{BATCH} = 1 }

plan tests => 7;

use_ok("Tk::FlatCheckbox");

my $top = tkinit;
#$top->optionAdd("*FlatCheckbox*background" => "green", "userDefault");
my $p = $top->Photo(-file => Tk->findINC("icon.gif"));
my $on = 0;
my $on2;
my $cb = $top->FlatCheckbox(-image => $p,
			    -variable => \$on,
			    -command => sub { warn $on },
			    -borderwidth => 20,
			   )->pack;
isa_ok($cb, "Tk::FlatCheckbox");
my $cb2 = $top->FlatCheckbox(-image => $p,
			     -variable => \$on,
			     -command => sub { warn $on },
			     -raiseonenter => 1,
			    )->pack;
isa_ok($cb2, "Tk::FlatCheckbox");
my $cb3 = $top->FlatCheckbox(-text => "Text",
			     -variable => \$on,
			     -command => sub { warn $on },
			    )->pack;
isa_ok($cb3, "Tk::FlatCheckbox");
my $cb4 = $top->FlatCheckbox(-text => "Text",
			     -variable => \$on,
			     -command => sub { warn $on },
			     -raiseonenter => 1,
			    )->pack;
isa_ok($cb4, "Tk::FlatCheckbox");
my $cb5 = $top->FlatCheckbox(-text => "Other value",
			     -variable => \$on2,
			     -command => sub { warn $on2 },
			     -raiseonenter => 1,
			     -onvalue => "on",
			     -offvalue => "off",
			    )->pack;
isa_ok($cb5, "Tk::FlatCheckbox");

my $sb = $top->Checkbutton(-text => "Shared",
			   -variable => \$on,
			  )->pack;
if (!$ENV{BATCH}) {
    MainLoop;
} else {
    $top->update;
    $cb->invoke;
    $top->update;
    select undef, undef, undef, 0.3;
    if ($on != 1) {
	exit 1;
    }
    $cb->invoke;
    $top->update;
    if ($on != 0) {
	exit 2;
    }
}

pass("FlatCheckbox demo");

__END__
