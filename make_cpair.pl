#!/usr/bin/perl -w

# Generates C files .h and .c

die "You got to define <file>" unless ($ARGV[0]);
my($fname, @mode) = $ARGV[0], undef;

# Remove all white spaces, dots here ...
$fname =~ s/[\s\.]/_/;

# Create var for using as the #define macro. Remove white spaces, upper case all.
$fname_macro = $fname;
$fname_macro =~ tr/[a-z]/[A-Z]/;

# Mode: ch, h, c
{
	my(@mode_tmp) = undef;
	die "You got to define <mode>" unless ($ARGV[1]);
	@mode_tmp = split('', $ARGV[1]);
	foreach(@mode_tmp){
		$mode{$_} = 1;
	}
}


# If files exist, throw error ...
($mode{"c"}) and (-e "$fname.c") and die ("File $fname.c already exists!");
($mode{"h"}) and (-e "$fname.h") and die ("File $fname.h already exists!");

# Create and open files (.c and .h)
($mode{"c"}) and (open (fs_c, ">$fname.c") or die ("Could not generate file $fname.c, $!"));
($mode{"h"}) and (open (fs_h, ">$fname.h") or die ("Could not generate file $fname.h, $!"));

#  Print code templates
# The .c file
($mode{"c"}) and $file_c = 
"/**
 * \@file $fname.c
 * \@author Fabrice Leal <fabrice [dot]leal[dot]ch[at]gmail[dot]com>
 *
 * \@section LICENSE
 *
 * < ... goes here ... >
 *
 * \@section DESCRIPTION
 * 
 * < ... goes here ... >
 *
 */

#include \"$fname.h\"


";

# The .h file
($mode{"h"}) and $file_h = 
"/**
 * \@file $fname.h
 * \@author Fabrice Leal <fabrice [dot]leal[dot]ch[at]gmail[dot]com>
 *
 * \@section LICENSE
 *
 * < ... goes here ... >
 *
 * \@section DESCRIPTION
 * 
 * < ... goes here ... >
 *
 */


// VAMI stands for Validation Against Multiple Includes :)

#ifndef ___VAMI_$fname_macro
#define ___VAMI_$fname_macro

// A header file only declares the functions headers and structs used. 
// Implementations go into the .c file ;)


#endif // ___VAMI_$fname_macro
";

# Prints to files ...
($mode{"c"}) and print fs_c $file_c ;
($mode{"h"}) and print fs_h $file_h ;

# Close files 
($mode{"c"}) and close fs_c ;
($mode{"h"}) and close fs_h ;


