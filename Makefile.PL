#
# Attention automated build system engineers:
# 
# If you're looking for a way to force the Makefile to be
# created even choose isn't installed in an automated
# way which doesn't require you to answer "y" to the interactive prompt
# then set the PERL_CHOOSE_FORCE enviroment variable to a true value
#     -- Mark
#

use ExtUtils::MakeMaker;

BEGIN {

	# indicate for CPAN testers that we only support OS X
	unless ($^O eq "darwin") {
		die "OS unsupported\n";
	}

	# check that choose is installed
	unless (`choose -v` =~ /^choose [0-9.]+$/ || $ENV{PERL_CHOOSE_FORCE}) {
		print STDERR <<'BLURB';
This module requires 'choose' to be installed.

You can download a version of 'choose' from:

     http://tinyrobotsoftware.com/choose/

If you do not have this installed then the tests will fail.
BLURB
		my $q = ExtUtils::MakeMaker::prompt("Continue with install (y/n)?","n");

		# as per http://wiki.cpantesters.org/wiki/CPANAuthorNotes
		exit 0 unless $q =~ /y/i;
	}
}

use inc::Module::Install;

name           'Mac-Choose';
all_from       'lib/Mac/Choose.pm';

requires       'Test::More'       => 0;

license 'perl';
githubmeta;
author_tests('xt');
readme_from    'lib/Mac/Choose.pm';

WriteAll;
