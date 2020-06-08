range2cidr
==========

**range2cidr** - program to convert iblocklist IP ranges to CIDR format

range2cidr [range…] will translate IP ranges into the standard CIDR notation. It also accepts piped data, for example:

    echo [range…] | range2cidr

Usage
-----

**`range2cidr`** is a program that converts iblocklist / bluetack style IP ranges to CIDR format.

    range2cidr [ options ] " IP-RANGE" ...
    
    range2cidr [ options ] " < files" ...
    
    cat files... | range2cidr

This program takes input as IP ranges with dash separated (`-`) pairs,
and converts these into their equivalent CIDR range notation(s).

For example:

    IP-RANGE
             => CIDR(s)
    1.22.65.175-1.22.65.175
             => 1.22.65.175/32
    192.168.0.0-192.168.255.255
             => 192.168.0.0/16
    86.66.128.0-86.70.225.255
             => 86.66.128.0/17
                86.67.0.0/16
                86.68.0.0/15
                86.70.0.0/17
                86.70.128.0/18
                86.70.192.0/19
                86.70.224.0/23


