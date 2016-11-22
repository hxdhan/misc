use strict;
use warnings;
use feature qw(say);

my $ip ='192.168.2.1';
#my $dec = unpack('N32',pack("C4", split(/\./,$ip)));
#$dec = unpack('H32',pack("C4", split(/\./,$ip)));
say pack "C*", split /\./, $ip; 
my $dec = unpack 'N', pack "C*", split /\./, $ip;
say "IP:$ip equals $dec";
say join '.', unpack "C*", pack "N*", $dec;
say join '.', unpack "C*", pack "H*", $Hex_ip;
