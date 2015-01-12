#!/usr/bin/perl -w
package esmith::FormMagick::Panel::bugreport;

use strict;
use warnings;
use esmith::ConfigDB;
use esmith::FormMagick;
use Text::Template;

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

sub create_template
{
    # TBD
}


sub create_configuration_report
{
    my $fm = shift;
    my $q = $fm->{'cgi'};
    
    # TBD: possibly check $q for a boolean value eg. from a checkbox
    # indicating the user has read privacy warning etc.
    
    # create the reporting template
    my $configreport_template = Text::Template->new(TYPE => 'FILE', SOURCE => '/usr/share/smeserver-bugreport/configuration_report.tmpl', UNTAINT => 1);
    my $report_creation_time = $fm->gen_locale_date_string;
    
    # get additional RPMs
    my @newrpms = `/sbin/e-smith/audittools/newrpms`;
    
    # get additional Repositories
    my @repositories = `/sbin/e-smith/audittools/repositories`;
    print @repositories; 
    
    # set template variables
    my %vars = (report_creation_time => \$report_creation_time,
               releaseversion => \$releaseversion,
               systemmode => \$systemmode,
               newrpms => \@newrpms,
               repositories => \@repositories,
               ); 

    # prcess template
    my $result = $configreport_template->fill_in(HASH => \%vars);

    # write processed template to file
    open (my $cfgrep, '>', $configreportfile) or die "Could not create temporary file for config report!"; 
    print $cfgrep $result;
    close $cfgrep;
}

sub show_config_report {
    my $fm = shift;
    my $q = $fm->{'cgi'};
    print "<PRE>";
    open (my $cfgrep, '<', $configreportfile) or die "Could not find temporary config report file!";
    print while <$cfgrep>;
    close $cfgrep;
    print "</PRE>";
    # that would be too easy!?
    print "<a href=\"$configreportfile\">Download this report</a>";



}

1;
