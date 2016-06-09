#!/usr/bin/perl

use strict;
use warnings;
use LWP;
use JSON;

for (my $i = 0; $i < 30; $i++) {
	my $url = "https://api.instagram.com/v1/users/self/media/recent/?access_token=[your non-sandbox access token]";

	if ($i > 0) {
		$url = $url . "&max_id=" . $lastid;
	}

	# Set the client
	my $browser = LWP::UserAgent->new;
	$browser->agent("instarchive 0.1");

	my  $request = new HTTP::Request GET => $url;
	my  $response = $browser->request($request)->content;

	# Parse the response
	my $data = decode_json($response);

	foreach my $post (@{$data->{data}}) {
		my $img = $post->{images}{standard_resolution}{url};
		my $link = $post->{link};
		my $guid = $post->{id};
		print $img;
		print ",";
		print $link;
		print ",";
		print $guid;
		print "\n";
		$lastid = $guid;
	}
}