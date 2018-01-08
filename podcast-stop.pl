#!/usr/bin/perl

use strict;
use warnings;
use XML::RSS;
use POSIX qw(strftime);
use lib '/afs/dsrw.org/users/dlg/usr/bin';
use Podcast;



my $cast = shift;
exit unless $cast;

exit unless $Podcast::data->{$cast};

my $d = $Podcast::data->{$cast};


`kill \`cat /tmp/$cast.wget.pid\``;
`rm -f /tmp/$cast.wget.pid`;
my @months = (undef,"jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
my $localtime = strftime("%a, %d %b %Y %H:%M:%S %z", localtime(time()));


my $rss = sprintf '<?xml version="1.0" encoding="UTF-8"?>
<rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
<channel>
  <title>%s</title>
  <link>https://www.dsrw.org/~dlg/auto/%s.rss</link>
  <language>en-us</language>
  <description>%s</description>
  <itunes:image href="https://www.dsrw.org/radio/i/%s.jpg"/>
  <itunes:author>%s</itunes:author>
',$d->{title},$cast,$d->{title},$cast,$d->{title};
$rss .= "  <lastBuildDate>$localtime</lastBuildDate>
  <pubDate>$localtime</pubDate>\n";




for (reverse glob "/local/radio/$cast/*.mp3")
{
  my (undef,undef,undef,undef,undef,undef,undef,$size,undef) = stat;

  $_ =~ s|/local|https://www.dsrw.org|;
  my ($year,$month,$date) = $_ =~ /_(\d{4})\.(\d{2})\.(\d{2})/;
  #print "$_\n";
  $rss .= "  <item>\n    <title>$d->{title} ... " . $months[$month] . " $date</title>\n    <link>$_</link>\n    <guid>$_</guid>\n    <enclosure url=\"$_\" type=\"audio/mpeg\" length=\"$size\"/>\n  </item>\n";
}


$rss .= "</channel>
</rss>
";
#print "$rss";
open FH,">/home/dlg/public_html/auto/$cast.rss" or die $!;
print FH "$rss";
close FH;
