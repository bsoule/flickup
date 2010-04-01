#!/usr/bin/env perl

#use Flickr::API;
use Flickr::Upload;

require "$ENV{HOME}/.flickuprc";

my $ua = Flickr::Upload->new( {'key' => $flickr_key, 'secret' => $flickr_secret} );
$ua->agent("danthany perl upload");

opendir(FLICKR, $inbox) || die "Cannot open inbox directory $inbox: $!";
while(my $fn = readdir FLICKR) {
  next if $fn !~ /[^\.]/;
  next if $fn =~ /(^\.|\.db$)/;

  print "$inbox/$fn ... ";

  $success = $ua->upload('auth_token' => $auth_token,
                         'photo' => "$inbox/$fn",
                         'is_public' => 1,
                         'is_friend' => 1,
                         'is_family' => 1,
                         'tags' => 'flickup',
                        );
  if($success) {
    system("mv $inbox/$fn $succdir/$fn");
    print "SUCCESS!\n";
  } else {
    system("mv $inbox/$fn $faildir/$fn");
    print "FAIL!\n";
  }
}

