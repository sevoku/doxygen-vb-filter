#----------------------------------------------------------------------------
# vbfilter.awk - doxygen VB .NET filter script - v1.2
#
# Creation:     26.05.2010  Vsevolod Kukol
# Last Update:  10.06.2010  Vsevolod Kukol
#
# Copyright (c) 2010 Vsevolod Kukol, sevo(at)sevo(dot)org
#
# Inspired by the Visual Basic convertion script written by
# Mathias Henze. Rewritten from scratch for VB .NET by
# Vsevolod Kukol.
#
# requirements: doxygen, gawk
#
# usage:
#    1. create a wrapper shell script:
#        #!/bin/sh
#        gawk -f /path/to/vbfilter.awk "$1"
#        EOF
#    2. define wrapper script as INPUT_FILTER in your Doxyfile:
#        INPUT_FILTER = /path/to/vbfilter.sh
#    3. take a look on the configuration options in the Configuration
#       section of this file (inside BEGIN function)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#---------------------------------------------------------------------------- 


BEGIN{
#############################################################################
# Configuration
#############################################################################
	# unix line breaks
	# set to 1 if using doxygen on unix with
	# windows formatted sources
	UnixLineBreaks=1;
	
	# leading shift inside classes/namespaces/etc.
	# default is "\t" (tab)
	ShiftRight="\t";
	#ShiftRight="    ";
	
	# add namespace definition at the beginning using project directory name
	# should be enabled, if no explicit namespaces are used in the sources
	# but doxygen should recognize package names.
	# in C# unlike in VB .NET a namespace must always be defined
	leadingNamespace=1;
	
#############################################################################
# helper variables, don't change
#############################################################################
	printedFilename=0;
	fileHeader=0;
	fullLine=1;
	insideClass=0;
	insideSubClass=0;
	insideNamespace=0;
	insideComment=0;
	insideImports=0;
	isInherited=0;
	lastLine="";
	appShift="";
}

#############################################################################
# shifter functions
#############################################################################
function AddShift() {
	appShift=appShift ShiftRight;
}

function ReduceShift() {
	appShift=substr(appShift,0,length(appShift)-length(ShiftRight));
}

#############################################################################
# apply dos2unix
#############################################################################
UnixLineBreaks==1{
	sub(/\r$/,"")
}

#############################################################################
# merge multiline statements into one line
#############################################################################
fullLine==0{
	fullLine=1;
	$0= lastLine$0;
	lastLine="";
}
/_$/{
	fullLine=0;
 	sub(/_$/,"");
 	lastLine=$0;
 	next;

}

#############################################################################
# skip empty lines
#############################################################################
/^$/ { next; }

#############################################################################
# remove leading whitespaces and tabs
#############################################################################
/^[ \t]/{
	sub(/^[ \t]*/, "")
}

#############################################################################
# remove Option and Region statements
#############################################################################
(/^#Region[[:blank:]]+/ ||
/.*Option[[:blank:]]+/) && insideComment!=1 {
	next;
}

#############################################################################
# parse file header comment
#############################################################################

/.*'/ && fileHeader!=2 {
	# check if header already processed
	if (fileHeader==0) {
		fileHeader=1;
		printedFilename=1
		# print @file line at the beginning
		file=gensub(/\\/, "/", "G", FILENAME)
		print "/**\n * @file "basename[split(file, basename , "/")];
	}
	sub(".*'+"," * ");		# remove leading "'"
	print $0;
	next;
}

# if .*' didn't match but header was processed, then
# the header ends here
fileHeader!=2 {
	if (fileHeader!=0) {
		print " */";
	}
	fileHeader=2;
}

#############################################################################
# print simply @file, if no file header found
#############################################################################
printedFilename==0 {
	printedFilename=1;
	file=gensub(/\\/, "/", "G", FILENAME)
	print "/// @file "basename[split(file, basename , "/")]"\n";
}

#############################################################################
# convert Imports to C# style
#
# remark: doxygen seems not to recognize
#         c# using directives so converting Imports is maybe useless?
#############################################################################
/.*Imports[[:blank:]]+/ {
	sub("Imports","using");
	print $0";";
	insideImports=1;
	next;
}

#############################################################################
# print leading namespace after the using section (if presend)
# or after the file header.
# namespace name is extracted from file path. the last directory name in
# the path, usually the project folder, is used.
#
# can be disabled by leadingNamespace=0;
#############################################################################
(!/^Imports[[:blank:]]+/) && leadingNamespace<=1 && fileHeader==2{
	if (leadingNamespace==1) {	# leading namespace enabled?
		file=gensub(/\\/, "/", "G", FILENAME)
		# get project name from the file path
		print "namespace "basename[split(file, basename , "/")-1]" {";
		leadingNamespace=2;	# is checked by the END function to print corresponding "}"
		AddShift()
	} else {
		# reduce leading shift
		leadingNamespace=3;
	}
	insideImports=0;
}
	


#############################################################################
# handle comments
#############################################################################

## beginning of comment
(/^[[:blank:]]*'''[[:blank:]]*/ || /^[[:blank:]]*'[[:blank:]]*[\\<][^ ].+/) && insideComment!=1 {
	if (insideEnum==1){	
		# if enum is being processed, add comment to enumComment
		# instead of printing it
		if (enumComment!="") {
			enumComment = enumComment "\n" appShift "/**";
		} else {
			enumComment = appShift "/**";
		}
		
	} else {
	
		# if inheritance is being processed, then add comment to lastLine
		# instead of printing it and process the end of
		# class/interface declaration
		
		if (isInherited==1){
			isInherited=0;
			if (lastLine!="") print appShift lastLine;
			print appShift "{"
			AddShift()
			lastLine="";
		}
		print appShift "/**"
	}
	insideComment=1;
}

## strip leading '''
/^[[:blank:]]*'/ {
	if(insideComment==1){
		commentString=gensub("[']+"," * ","g",$0);
		# if enum is being processed, add comment to enumComment
		# instead of printing it
		if (insideEnum==1){
			enumComment = enumComment "\n" appShift commentString;
		} else {
			print appShift commentString;
		}
		next;
	}
}

## end of comment
(!(/[[:blank:]]*'/)) && insideComment==1 {
	# if enum is being processed, add comment to enumComment
	# instead of printing it
	if (insideEnum==1){	
		enumComment = enumComment "\n" appShift " */";
	} else {
		print appShift " */";
	}
	insideComment=0;
}


#############################################################################
# inline comments in c# style /** ... */
#############################################################################
# strip all commented lines, if not part of a comment block
/^'+/ && insideComment!=1 {
	next;
}
/.+'+/ && insideComment!=1 {
	sub("[[:blank:]]*'"," /**<");
	$0 = $0" */"
}


#############################################################################
# simple rewrites
# vb -> c# style
#############################################################################
/^Private[[:blank:]]+/ {
	sub(".*Private[[:blank:]]+","private ");
}
/^Public[[:blank:]]+/ {
	sub(".*Public[[:blank:]]+","public ");
}
# friend is the same as internal in c#, but Doxygen doesn't support internal,
# so make it private to get it recognized by Doxygen) and Friend appera
# in Documentation
/^Friend[[:blank:]]+/ {
	sub(".*Friend[[:blank:]]+","private Friend ");
}
/^Protected[[:blank:]]+/ {
	sub(".*Protected[[:blank:]]+","protected ");
}
# add "static" to all Shared members
/^Shared[[:blank:]]+/ {
	sub("Shared", "static Shared");
}


#############################################################################
# Enums
#############################################################################
/^Enum[[:blank:]]+/ || /[[:blank:]]+Enum[[:blank:]]+/ {
	sub("Enum","enum");
	sub("+*[[:blank:]]As.*",""); # enums shouldn't have type definitions
	print appShift $0"\n"appShift"{";
	insideEnum=1;
	lastEnumLine="";
	AddShift()
	next;
}

/^[ \t]*End[[:blank:]]+Enum/ && insideEnum==1{
	print appShift lastEnumLine;
	ReduceShift()
	print appShift "}"
	insideEnum=0;
	lastEnumLine="";
	enumComment="";
	next;
}

insideEnum==1 {
	if ( lastEnumLine == "" ) {
		lastEnumLine = $0;
		if (enumComment!="") print enumComment;
		enumComment="";
	} else {
		commentPart=substr(lastEnumLine,match(lastEnumLine,"[/][*][*]<"));
		definitionPart=substr(lastEnumLine,0,match(lastEnumLine,"[/][*][*]<")-2);
		if (definitionPart=="") print appShift commentPart ",";
		else {
			print appShift definitionPart ", " commentPart
		}
		lastEnumLine = $0;
		# print leading comment of next element, if present
		if (enumComment!="") print enumComment;
		enumComment="";
	}
	next;
}

#############################################################################
# Declares
#############################################################################
#[DllImport("kernel32.dll")]


/.*Declare[[:blank:]]+/ {
	libName=gensub(".+Lib[[:blank:]]+\"([^ ]*)\"[[:blank:]].*","\\1","g");
	if (match($0,"Alias")>0) aliasName=gensub(".+Alias[[:blank:]]+\"([^ ]*)\"[[:blank:]].*"," (Alias: \\1)","g");
	print appShift "/** Is imported from extern library: " libName aliasName " */";
	libName="";
	aliasName="";
}

# remove lib and alias from declares
/.*Lib[[:blank:]]+/ {
	sub("Lib[[:blank:]]+[^[:blank:]]+","");
	sub("Alias[[:blank:]]+[^[:blank:]]+","");
}



#############################################################################
# types (handle As)
#############################################################################

## converts a single type definition to c#
##  "Var As Type" -> "Type Var"
function convertSimpleType(Param)
{
	l=split(Param, aParam, " ")
	newParam="";
	for (j = 1; j <= l; j++) {
		if (aParam[j] == "As") {			
			aParam[j]=aParam[j-1];
			aParam[j-1]=aParam[j+1];
			aParam[j+1]="";
		}
	}
	for (j = 1; j <= l; j++) {
		if (aParam[j]!="") {
			if (j == 1) {
				newParam=aParam[j];
			} else {
				newParam=newParam " " aParam[j];
			}
		}
	}
	l="";
	delete aParam;
	return newParam;
}


/.*As[[:blank:]]+/ {
	gsub("ByVal","");
	# keep ByRef to make pointers differ from others
	#gsub("ByRef","");
	
	# handle array types
	# replace type() with type[]
	lFull=split($0, aFull , " ")
	$0="";
	for (i = 1; i <= lFull; i++) {
		if (aFull[i] == "As") aFull[i+1]=gensub("[(][)]","[]","g",aFull[i+1]);
		if (i == 1) {
			$0=aFull[i];
		} else {
			$0=$0 " " aFull[i];
		}
	}
	
	# simple member definition without brackets
	if (index($0,"(") == 0) {
		$0=convertSimpleType($0);
	} else {
		# parametrized member
		
		preParams=substr($0,0,index($0,"(")-1) 
		lpreParams=split(preParams, apreParams , " ")
		
		Params=substr($0,index($0,"(")+1,index($0,")")-index($0,"(")-1) 
		lParams=split(Params, aParams, ",")
		Params="";
		# loop over params and convert them
		if (lParams > 0) {
			for (i = 1; i <= lParams; i++) {
				if (i == 1) {
					Params=convertSimpleType(aParams[i]);
				} else {
					Params=Params ", " convertSimpleType(aParams[i]);
				}
			}
		}
		
		postParams=substr($0,index($0,")")+1) 
		
		# handle type def of functions and properties
		lpostParams=split(postParams, apostParams , " ")
		if (lpostParams > 0) {
			if (apostParams[1] == "As") {
				apreParams[lpreParams+1]=apreParams[lpreParams];
				apreParams[lpreParams]=apostParams[2];
				lpreParams++;
				apostParams[1]="";
				apostParams[2]="";
			}			
		}
		
		# put everything back together
		$0="";
		for (i = 1; i <= lpreParams; i++) {
			if (apreParams[i]!="")	$0=$0 apreParams[i]" ";
		}
		
		$0=$0 "("Params") ";
		
		for (i = 1; i <= lpostParams; i++) {
			if (apostParams[i]!="")	$0=$0 apostParams[i]" ";
		}
		
		# cleanup mem
		lParams="";
		delete aParams;
		lpostParams="";
		delete apostParams;
		lpreParams="";
		delete apreParams;
	}
}

#############################################################################
# namespaces
#############################################################################
/^Namespace[[:blank:]]+/ || /[[:blank:]]+Namespace[[:blank:]]+/ {
	sub("Namespace","namespace");
	insideNamespace=1;
	print appShift $0" {";
	AddShift();
	next;
}

/^.*End[[:blank:]]+Namespace/ && insideNamespace==1{
	ReduceShift();
	print appShift "}";
	insideNamespace=0;
	next;
}

#############################################################################
# interfaces
#############################################################################
/.*Interface[[:blank:]]+/ || /.*Class[[:blank:]]+/ || /.*Structure[[:blank:]]+/ {
	sub("Interface","interface");
	sub("Class","class");
	sub("Structure","struct");
	
	# handle subclasses
	if (insideClass==1) {
		insideSubClass=1;
	} else {
		insideClass=1;
	}
	
	# save class name for constructor handling
	className=gensub(".+class[[:blank:]]+([^ ]*).*","\\1","g");
	
	isInherited=1;
	print appShift $0;
	next;
}

# handle constructors
/.*Sub[[:blank:]]+New.*/ && className!="" {
	sub("New", "New " className);
}


# handle inheritance
isInherited==1{
	if(($0 ~ /^[[:blank:]]*Inherits[[:blank:]]+/) || ($0 ~ /^[[:blank:]]*Implements[[:blank:]]+/)) {
		
		if ( lastLine == "" )
		{
			sub("Inherits",":");
			sub("Implements",":");
			lastLine=$0;
		}
		else
		{
			sub(".*Inherits",",");
			sub(".*Implements",",");
			lastLine=lastLine $0;
		}
	}
	else {
		isInherited=0;
		if (lastLine!="") print appShift lastLine;
		print appShift "{";
		AddShift();
		lastLine="";
	}
}

(/^.*End[[:blank:]]+Interface/ || /.*End[[:blank:]]+Class.*/ || /^.*End[[:blank:]]+Structure/) && (insideClass==1 || insideSubClass==1){
	if (insideSubClass==1) {
		insideSubClass=0;
	} else {
		insideClass=0;
	}
	ReduceShift();
	print appShift "}";
	className="";
	next;
}



#############################################################################
# Properties
#############################################################################
/.*[[:blank:]]Property[[:blank:]]+/ {
	# add c# styled get/set methods
	if (match($0,"ReadOnly")) {
		#sub("ReadOnly[[:blank:]]","");
		$0=$0" { get; }"
	} else {
		$0=$0" { get; set; }"
	}
	print appShift $0
	next
}

#############################################################################
# process everything else
#############################################################################
/.*private[[:blank:]]+/ ||
/.*public[[:blank:]]+/ ||
/.*protected[[:blank:]]+/ ||
/.*friend[[:blank:]]+/ ||
/.*Sub[[:blank:]]+/ ||
/.*Function[[:blank:]]+/ ||
/.*Declare[[:blank:]]+/ ||
/.*[[:blank:]]Event[[:blank:]]+/ ||
/.*Const[[:blank:]]+/ {

	
	# remove square brackets from reserved names
	# but do not match array brackets
	#  "Integer[]" is not replaced
	#  "[Stop]" is replaced by "Stop"	
	$0=gensub("([^\[])([\]])","\\1","g");
	$0=gensub("([\[])([^\]])","\\2","g");
	
	# add semicolon before inline comment
	if( $0 != "" ){	
		commentPart=substr($0,index($0,"/"));
		definitionPart=substr($0,0,index($0,"/")-1);
		if ( definitionPart != "" && commentPart != "") {
			print appShift definitionPart"; "commentPart
		} else {
			print appShift $0";";
		}
	}
}

END{
	# close file header if file contains no code
	if (fileHeader!=2 && fileHeader!=0) {
		print " */";
	}
	if (leadingNamespace==2) print "}";
}
