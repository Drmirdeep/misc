#!/usr/bin/perl

use strict;
use warnings;

## Author: Sebastian Mackowiak
## Date: 02.09.2017
## Version: 0.0.1

## output d significant digits
sub r{
	my ($n,$d)=@_;
	if($n =~ /[a-zA-Z]/){return $n;}
	return ((int($n*(10**$d)))/(10**$d));
}


## get a jquery.min.js file if not present
if(not -f "jquery.min.js"){
	print STDERR "jquery min not found\nTrying to download it from https://code.jquery.com/jquery-3.2.1.min.js\n";
	system("wget -O jquery.min.js https://code.jquery.com/jquery-3.2.1.min.js");
}


open OUT,">$ARGV[0].html" or die "Could not create $ARGV[0].html\n";
while(<DATA>){
	next if(/##/);
	print OUT;
}


print OUT "
<img src=\"$ARGV[0].png\" alt=\"Scatterplot\" usemap=\"#scatter\">
<map name=\"scatter\">
";

open IN,"$ARGV[0].id" or die "No table with ids given of datapoints in png";

## layout of tooltip table is 
## gid id value id value etc
my $c=0;
while(<IN>){
	$c++;
	my @l=split();
	
	print OUT <<EOF;
	<div id="id_$c" class="tt">
		<!-- <img src="venglobe.gif" width="50" height="50" alt="id">
		This is tooltip $c with $l[0] -->
		<table>
EOF
	for(my $i=1;$i<=$#l;$i+=2){
		print OUT "<tr><td>",r($l[$i],2),"</td><td>",r($l[$i+1],2),"</td></tr>";
	}
	print OUT "</table>\n</div>\n";
}

close IN;

open IN,"$ARGV[0].csv" or die "No file with x,y coordinates given\n";
$c=0;
while(<IN>){
	my @l=split();
	$c++;
	print OUT "<area shape=\"circle\" coords=\"",int($l[1]),",",int($l[2]),",8\" onmouseover=\"h(event,\'id_$c\')\" onmouseout=\"h(event,\'id_$c\')\" >\n";

}
close IN;
print OUT "
</map>
</body>
</html>
";
close OUT;


__DATA__
<!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="utf-8"/>
	<title>test</title>
	<script type="text/javascript" src="jquery.min.js"></script>
	<script>

		## this is our function executed on mouseover event
		## the id parameter is suppilied and is the id of the <div> we are showing
		## the e parameter is an internal one needed by the function and is
		## the actual event otherwise event.clientX wouldnt work
			
		function h(e,id){

		var left  = e.clientX  + "px";
		var top  = e.clientY  + "px";

		## just getting the div so below we can say 
		var div = document.getElementById(id);

		## div. etc to modify the style ( it gets the left and top params from above)
		div.style.left = left;
		div.style.top = top;

		## and here we simply use the toggle() function 
		$("#"+id).toggle();
		return false;
	}
	</script>

	## defining what the class tt is
	<style>
	
	.tt{
		position: fixed;
		display:none;
	}

	body{
		position: relative;
	}
	</style>
	<body>


