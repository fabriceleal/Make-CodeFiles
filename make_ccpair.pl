#!/usr/bin/perl -w

# Generates C++ .cc and .h class files

die "You have to define <namespace-name>" unless ($ARGV[0]);
die "You have to define <class-name>" unless ($ARGV[1]);

my($namespace, $fname, @mode) = $ARGV[0], $ARGV[1], undef;

# Remove all white spaces, dots here ... replace by '_'
$fname =~ s/[\s\.]/_/;
$namespace =~ s/[\s\.]/_/;

# Create var for using as the #define macro. Remove white spaces, upper case all.
$fname_macro = "$namespace\__$fname";
$fname_macro =~ tr/[a-z]/[A-Z]/;

my($ext_code, $ext_header) = ('cc', 'h');

# Mode: ch, h, c
{
	my(@mode_tmp) = undef;
	die "You got to define <mode>" unless ($ARGV[2]);
	@mode_tmp = split('', $ARGV[2]);
	foreach(@mode_tmp){
		$mode{$_} = 1;
	}
}

# If files exist, throw error ...
($mode{"c"}) and (-e "$fname.$ext_code") and die ("File $fname.$ext_code already exists!");
($mode{"h"}) and (-e "$fname.$ext_header") and die ("File $fname.$ext_header already exists!");

# Create and open files (.c and .h)
($mode{"c"}) and (open (fs_c, ">$fname.$ext_code") or die ("Could not generate file $fname.$ext_code, $!"));
($mode{"h"}) and (open (fs_h, ">$fname.$ext_header") or die ("Could not generate file $fname.$ext_header, $!"));

my($file_c, $file_h);

# TODO: put here templates
# TODO: dont forget the 'extern "C"' trick

($mode{"c"}) and $file_c = "

";

($mode{"h"}) and $file_h = "

namespace $__1 {

	class $__2
	{
		public:
		
		private:
		
	}
}

";

# Prints to files ...
($mode{"c"}) and print fs_c $file_c ;
($mode{"h"}) and print fs_h $file_h ;

# Close files
($mode{"c"}) and (close (fs_c));
($mode{"h"}) and (close (fs_h));


