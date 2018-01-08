package Podcast;

use strict;
use warnings;
our $data =
  { classical =>   { url => "http://cms.stream.publicradio.org/cms.mp3",
                     title => "IPR Classical Overnight" },
    coffeebreak => { url => "http://current.stream.publicradio.org/kcmp.mp3",
                     title => "Coffee Break" },
    rtc =>         { url => "http://rockthecradle.stream.publicradio.org/rockthecradle.mp3",
                     title => "Rock The Cradle" },
    thecurrent =>  { url => "http://current.stream.publicradio.org/kcmp.mp3",
                     title => "The Current" }
  };

1;
