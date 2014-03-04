#!/usr/bin/perl
# $Id: out-gridview.pl 3435 2014-02-06 12:55:53Z knb $
# $HeadURL: http://svn.gfz-potsdam.de/icdp/scratch/trunk/perl-module/bin/out-gridview/out-gridview.pl $
# display results from database query in a GUI
# call this on the command line, in a unix pipeline.
# expects results in a series of key:value pairs
# separated by lines with single blank
# 
# Pipe
#
=pod
 Expected Input 
 produced by a shell-one-liner such as this pipe:
 
sqsh  -Smysrv  -Uguest -Psecrit -Dtempdb -m vert  -i in-out-files/test-1.sql <<SQL  | perl   ./out-gridview.pl
sp_who;
SQL

=cut

=pod
sqsh is a free, open source command-line client for Sybase and Microsoft SQL Server databases.
Usage of the -m vert option is critical here. This returns data in a key:value manner instead of a columnar layout.
This perl script turns the columnar layout into a grid-view again.
=cut

=pod
Expected output (only 2 records shown)

spid:       61
ecid:       0
status:     sleeping                      
loginame:   knb
hostname:   h7                                                                                                         
blk:        0    
dbname:     master
cmd:        AWAITING COMMAND
request_id: 0
 
spid:       62
ecid:       0
status:     runnable                      
loginame:   knb
hostname:   h3                                                                                                         
blk:        0    
dbname:     tempdb
cmd:        SELECT          
request_id: 0
 

=cut


use strict;
use warnings;
use Tk;
use Tk::GridColumns;

my $mw = tkinit( -title => 'results from db query' );
$mw->geometry("=1300x400+100+100");

my $gc = $mw->Scrolled(
	'GridColumns' => -scrollbars => 'ose',
	-data         => \my @data,
	-columns      => \my @columns,
  )->pack(
	-fill   => 'both',
	-expand => 1,
  )->Subwidget('scrolled');    # do not forget this one ;)

{
	local $/ = "\n \n";
	while (<>) {
		if ( $. == 1 ) {
			@columns = get_columns( $_, $gc );
		} else {

			my $record = get_record($_);
			push @data, $record;
		}
	}
}

sub trim {
	my $str = shift;
	$str =~ s/^\s+//;
	$str =~ s/\s+$//;

	return $str;
}

sub get_columns {

	my $str      = shift;
	my $gc       = shift;
	my @rec      = split "\n", $str;
	my @colnames = ();
	map {
		my ( $k, $v ) = split ":";
		my %href;
		if ($k) {
			$href{"-text"} = trim($k);
			$href{"-command"} = $gc->sort_cmd( 1, 'abc' );
			push @colnames, \%href;
		} else {
			$href{"-text"} = "?";
			$href{"-command"} = $gc->sort_cmd( 1, 'abc' );
			push @colnames, \%href;
		}
	} @rec;
	return @colnames;
}

sub get_record {
	my $str = shift;
	my @rec = ();
	@rec = map { my ( $k, $v ) = split ":"; $v ? trim($v) : "" } split "\n", $str;
	return \@rec;
}

$gc->refresh;

MainLoop
