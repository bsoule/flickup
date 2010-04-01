#!/usr/bin/env perl

use Flickr::API;
use Flickr::Upload;

require "$ENV{HOME}/.flickuprc";

my $ua = Flickr::Upload->new( {'key' => $flickr_key, 'secret' => $flickr_secret} );
$ua->agent( "danthany perl upload" );

my $frob = getFrob( $ua );
my $url = $ua->request_auth_url('write', $frob);
print "1. Enter the following URL into your browser\n\n",
"$url\n\n",
"2. Follow the instructions on the web page\n",
"3. Hit enter when finished.\n\n";
<>;
my $auth_token = getToken( $ua, $frob );
die "Failed to get authentication token!" unless defined $auth_token;

print "Token is $auth_token\n";


sub getFrob {
my $ua = shift;

my $res = $ua->execute_method("flickr.auth.getFrob");
return undef unless defined $res and $res->{success};

# FIXME: error checking, please. At least look for the node named 'frob'.
return $res->{tree}->{children}->[1]->{children}->[0]->{content};
}

sub getToken {
my $ua = shift;
my $frob = shift;

my $res = $ua->execute_method("flickr.auth.getToken",
{ 'frob' => $frob ,
'perms' => 'write'} );
return undef unless defined $res and $res->{success};

# FIXME: error checking, please.
return $res->{tree}->{children}->[1]->{children}->[1]->{children}->[0]->{content};
}    
