#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use lib '/afs/dsrw.org/users/dlg/usr/bin';
use Podcast;



my $cast = shift;
exit unless $cast;

exit unless $Podcast::data->{$cast};

my $d = $Podcast::data->{$cast};

print `find /local/radio/$cast -type f -mtime +7 -delete -print`;
chomp(my $date = `date +%Y.%m.%d`);
open FH, "wget -bO /local/radio/$cast/${cast}_${date}.mp3 -o /tmp/$cast.wget.log $d->{url}|";
my $pid;
while (<FH>)
{
  next unless /pid/;
  ($pid) = $_ =~ m/pid (\d+)/;
}
close FH;
open FH,">/tmp/$cast.wget.pid" or die $!;
print FH "$pid\n";
close FH;


