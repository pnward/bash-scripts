#!/usr/bin/perl
#Here is a perl script that returns the top 10 largest directories.
#Use it by running perl dirsize.pl /var/*

use strict;
die "usage: $0 <directories> ie 10bigdir.pl /home/*\n" unless @ARGV;
@ARGV = map { "'$_'" } @ARGV;
my @results = `du -hs @ARGV`;
@results = sort human_sort @results;
@results = @results[0..9];
print @results;

#---------------------------------------------------------------------------
sub human_sort {
        my ($size_a) = $a =~ /^(\S+)/;
        my ($size_b) = $b =~ /^(\S+)/;

        $size_a = $1 * 1024 if $size_a =~ /^(.*)k$/;
        $size_a = $1 * 1024 * 1024 if $size_a =~ /^(.*)M$/;
        $size_a = $1 * 1024 * 1024 * 1024 if $size_a =~ /^(.*)G$/;

        $size_b = $1 * 1024 if $size_b =~ /^(.*)k$/;
        $size_b = $1 * 1024 * 1024 if $size_b =~ /^(.*)M$/;
        $size_b = $1 * 1024 * 1024 * 1024 if $size_b =~ /^(.*)G$/;

        return $size_b <=> $size_a;
}
