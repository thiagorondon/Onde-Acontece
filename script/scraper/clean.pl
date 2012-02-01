#!perl
open my $fh, "<cidade_codmun.txt";
while(<$fh>){s/\d{1,3},|"//g; s/,/|/g;print}
