	{\tiny{
	\begin{lstlisting}[language=Python]
#! /usr/bin/python3

# # Daniel Topa

# # imports
import datetime             # timestamps
import os                   # opeating system
import sys                  # python version
from pathlib import Path    # rename file
import xlsxwriter           # API for Excel
import tools_xl             # spreadsheet authoring tools
# home brew
# classes
import cls_TestObject

#  ==   ==   == ==   ==   == ==   ==   == ==   ==   ==  #

if __name__ == "__main__":

    series = '050'
    object = cls_TestObject.TestObject( )     # instantiate TestObject
    # populate object properties
    object.descriptor = "sphere"
    object.sizeName   = "diameter"
    object.sizeValue  = 10
    object.sizeUnits  = "m"
    object.areaUnits  = "m^2"
    object.resolution = "03"
    object.sourceFile = "sphere-" + series + "-" + object.resolution
    object.sourcePath = "/Tlaloc/python/sphere/"
    object.outputFile = 'sphere-d' + series + '-res' + object.resolution + '.xlsx'
    object.outputPath = "/Tlaloc/python/sphere/"
    object.setup_io( )
    object.area_circular( )

    # container for MoM data and results
    MoMresults = tools_xl.xl_new_workbook( object )

    # close MoMresults
    MoMresults.close( )
    print( "\n", datetime.datetime.now( ) )
    print( "source: %s/%s" % ( os.getcwd( ), os.path.basename( __file__ ) ) )
    print( "python version %s" % sys.version )

# root@f21d93a5a2e9:sphere $ date
# Wed Jun 24 01:20:41 MDT 2020
#
# root@f21d93a5a2e9:sphere $ pwd
# /Tlaloc/python/sphere
#
# root@f21d93a5a2e9:sphere $ python MoM.py
# output file RCS-sphere-10.xlsx
# source file sphere-050-01
# adding sheet 3 MHz
# adding sheet 4 MHz
# adding sheet 5 MHz
# adding sheet 6 MHz
# adding sheet 7 MHz
# adding sheet 8 MHz
# adding sheet 9 MHz
# adding sheet 10 MHz
# adding sheet 11 MHz
# adding sheet 12 MHz
# adding sheet 13 MHz
# adding sheet 14 MHz
# adding sheet 15 MHz
# adding sheet 16 MHz
# adding sheet 17 MHz
# adding sheet 18 MHz
# adding sheet 19 MHz
# adding sheet 20 MHz
# adding sheet 21 MHz
# adding sheet 22 MHz
# adding sheet 23 MHz
# adding sheet 24 MHz
# adding sheet 25 MHz
# adding sheet 26 MHz
# adding sheet 27 MHz
# adding sheet 28 MHz
# adding sheet 29 MHz
# adding sheet 30 MHz
#
#  2020-06-24 01:20:46.349142
# source: /Tlaloc/python/sphere/MoM.py
# python version 3.7.7 (default, Jun 22 2020, 22:42:46)
# [GCC 10.1.0]

# $ lsb_release -a
# LSB Version:	:core-4.1-amd64:core-4.1-noarch
# Distributor ID:	CentOS
# Description:	CentOS Linux release 7.8.2003 (Core)
# Release:	7.8.2003
# Codename:	Core
	\end{lstlisting}
	}}

\endinput  %  ==  ==  ==  ==  ==  ==  ==  ==  ==