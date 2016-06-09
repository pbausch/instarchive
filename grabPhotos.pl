#!/usr/bin/perl

use strict;
use warnings;
use LWP::Simple;
use DBI;

my $dbh = DBI->connect('DBI:mysql:database=[database]:host=localhost', '[username]', '[password]')
	or die "Cannot connect: " . $DBI::errstr;

my $exists = "SELECT img, url, id FROM instagram WHERE download = 0 LIMIT 100";
my $eth = $dbh->prepare($exists)
	or die "Cannot prepare: " . $dbh->errstr();
$eth->execute();

my $postcount = 0;
while (my @row = $eth->fetchrow_array) {
	my $id = $row[2];
	my $imgurl = $row[0];
	my $shortcode = $row[1];
	my $localimgname = $shortcode . ".jpg";
	getstore($imgurl, $localimgname) or die "Can't download: $@\n";
	
	my $sql = "UPDATE instagram SET download = 1 WHERE id = ?";
	my $sth = $dbh->prepare($sql)
		or die "Cannot prepare: " . $dbh->errstr();
	$sth->execute($id);
	sleep 1;
}