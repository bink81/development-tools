#!/usr/bin/perl -w

# This script allows to filter server log to show only important information
# Usage example (from console): "tail server.log -f | grep -v hibernate"
while(<STDIN>) {
    my $line = $_;
    chomp($line);
    for($line){
		s/ \[.+?\] /:/g; # don't show package that appears after log level [(..)]
		s/2015/15/g; # don't show package that appears after log level [(..)]
        s/.*exception:.*|at .*/\e[0;31m$&\e[0m/gi; # exceptions in red
        s/ info.*/\e[1;32m$&\e[0m/gi; # INFO in green
        s/ warn.*/\e[1;33m$&\e[0m/gi; # WARN in yellow
        s/ error.*/\e[0;31m$&\e[0m/gi; # ERROR in red
        s/ fatal.*/\e[0;31m$&\e[0m/gi; # FATAL in red
    }
    print $line, "\n";
}