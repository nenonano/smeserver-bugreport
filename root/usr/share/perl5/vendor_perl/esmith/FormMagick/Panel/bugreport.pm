#!/usr/bin/perl -w
 package esmith::FormMagick::Panel::bugreport;
 
 use strict;
 use warnings;
 use esmith::ConfigDB;
 use esmith::FormMagick;
 
 our @ISA = qw(esmith::FormMagick Exporter);
 
 our @EXPORT = qw();
 
 our $VERSION = sprintf '%d.%03d', q$Revision: 0.1 $ =~ /: (\d+).(\d+)/;
 
 our $db = esmith::ConfigDB->open or die "Couldn't open ConfigDB\n";
 
 sub create_report
 {
     my $fm = shift;
     my $q = $fm->{'cgi'};
 
 
     $fm->success('SUCCESS');
 }
 
 1;
