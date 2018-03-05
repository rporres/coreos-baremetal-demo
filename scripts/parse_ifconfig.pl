#!/usr/bin/env perl

use strict;
use warnings;

my $internal_inet_addr = shift;
$internal_inet_addr or die "Usage: $0 internal_inet_addr";

# enable paragraph mode
$/='';

my $internal_iface;
my $nat_iface;
while (<>) {
    my @lines = split /\n/;
    my $iface = (split /\s+/, $lines[0])[0];
    next if $iface eq "lo";
    $lines[1] =~ /inet addr:([^ ]+) /;
    my $inet_addr = $1;
    if ($inet_addr eq  $internal_inet_addr) {
        $internal_iface = $iface;
    }
    else {
        $nat_iface = $iface
    }
}

die "No matching interface for $internal_inet_addr"
    unless defined $internal_iface;

print "$nat_iface,$internal_iface";
