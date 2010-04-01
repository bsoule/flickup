#!/usr/bin/env perl

use Flickr::Upload;

my $ua = Flickr::Upload->new(
  {
     'key' => '90909354',
     'secret' => '37465825'
  });
$ua->upload(
   'photo' => '/Users/dreeves/Desktop/danny-faire-a2a-1.jpg',
   'auth_token' => $auth_token,
   'tags' => 'me myself eye',
   'is_public' => 1,
   'is_friend' => 1,
   'is_family' => 1
) or die "Failed to upload /tmp/image.jpg";
