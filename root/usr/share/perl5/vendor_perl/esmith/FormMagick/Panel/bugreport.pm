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

# Get some basic info on the current SME install
our $sysconfig = $db->get('sysconfig');
our $systemmode = $sysconfig->prop('PreviousSystemMode');
our $releaseversion = $sysconfig->prop('ReleaseVersion');

# Prepare some filehandles for templates and reports
our $templatefile = '/tmp/bugreport_template.txt';
our $configreportfile = '/tmp/configreport.txt';

sub new {
    shift;
    my $self = esmith::FormMagick->new();
    $self->{calling_package} = (caller)[0];
    bless $self;
    return $self;
}

sub get_newrpms_list {
    my @newrpms = `/sbin/e-smith/audittools/newrpms`;
    my $newrpmlist = join("\n", @newrpms);
    return $newrpmlist;
}

sub get_repositories_list {
    my @repositories = `/sbin/e-smith/audittools/newrpms`;
    my $repositorieslist = join("\n", @newrpms);
    return $repositorieslist;
}

sub create_report
{
    my $fm = shift;
    my $q = $fm->{'cgi'};
    
    # TBD: possibly check $q for a boolean value eg. from a checkbox
    # indicating the user has read privacy warning etc.
    

    # begin wrting to config report file
    open (my $cfgrep, '>', $configreportfile) or die "Could not create temporary file for config report!"; 
    my $current_datetime = $fm->gen_locale_date_string;
    print $cfgrep "Configuration report created on $current_datetime\n";

    # close config report file
    close $cfgrep;
    
    


    $fm->success('SUCCESS');
}

sub create_template
{
    # TBD
}

1;
