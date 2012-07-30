#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

BEGIN {
    use_ok('Mail::SendGrid::SmtpApiHeader') or die "Can't load Mail::SendGrid::SmtpApiHeader";
}


sub main {
    my $header = Mail::SendGrid::SmtpApiHeader->new();
    isa_ok($header, 'Mail::SendGrid::SmtpApiHeader');
    return 0;
}


exit main() unless caller;

