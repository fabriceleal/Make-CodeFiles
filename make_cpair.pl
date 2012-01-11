#!/usr/bin/perl -w

# Generates C files .h and .c

$fname = $ARGV[0];

# TODO: Create var for using as the #define macro. Remove white spaces, upper case all.

# TODO: Mode: .c+.h, .h, .c

# If files exist, throw error ...
(-e "$fname.c") and die ("File $fname.c already exists!");
(-e "$fname.h") and die ("File $fname.h already exists!");

# Create and open files (.c and .h)
open (fs_c, ">$fname.c") or die ("Could not generate file $fname.c, $!");
open (fs_h, ">$fname.h") or die ("Could not generate file $fname.h, $!");

#  Print code templates
# The .c file
$file_c = 
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

#include "$fname.h"


";

# The .h file
$file_h = 
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

#ifndef ___VAMI_$fname
#define ___VAMI_$fname

// A header file only declares the functions headers and structs used. 
// Implementations go into the .c file ;)


#endif // ___VAMI_$fname
";

# Prints to files ...
print fs_c $file_c ;
print fs_h $file_h ;

# Close files 
close fs_c ;
close fs_h ;


