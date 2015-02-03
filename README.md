#Doxygen Visual Basic filter

The  Doxygen Visual Basic filter is an [awk](http://en.wikipedia.org/wiki/AWK) script that converts
Classic VB and VB.NET code syntax to a C#-like syntax, so it
can be read and understood by Doxygen.

It is inspired by the Visual Basic (classic) filter script written
by Mathias Henze. More information about his script can be found in
the [Helper Tools section](http://www.stack.nl/~dimitri/doxygen/helpers.html#doxfilt_vb) on the Doxygen homepage. 


##How dows it work

Doxygen can preprocess all sources using a source filter. A source filter
must be executable, accept the name of the source path as last parameter
and print the resulting source to STDOUT. See the Doxygen manual for
more information.

The vbfilter.awk script is a AWK script, which can be executed using
gawk. Gawk reads the source files line by line, applys vbfilter.awk on
it and passes the output to doxygen. 


##Documentation
A complete documentation can be found in the [GitHub Project Wiki](https://github.com/sevoku/doxygen-vb-filter/wiki):
* [Features and Limitations](https://github.com/sevoku/doxygen-vb-filter/wiki/Features-and-Limitations)
* [Requirements](https://github.com/sevoku/doxygen-vb-filter/wiki/Requirements)
* [Environment Setup](https://github.com/sevoku/doxygen-vb-filter/wiki/Environment-Setup)
* [Filter configuration](https://github.com/sevoku/doxygen-vb-filter/wiki/Filter-configuration)
* [Documenting your sources](https://github.com/sevoku/doxygen-vb-filter/wiki/Documenting-your-sources)

##License
Copyright (c) 2010-2015 Vsevolod Kukol, sevo(at)sevo(dot)org

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.


