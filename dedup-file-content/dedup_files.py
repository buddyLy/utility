#!/usr/bin/evn python

import sys
import csv
import logging

def get_usr_input():
    """
    Get input from user command line
    arg1 -- first file 
    arg2 -- second file 
    """

    global file1
    global file2
   
    try: 
        file1 = sys.argv[1]
        file2 = sys.argv[2]
    except IndexError as error:
        print "Not enough arguments %s" % error
        raise IndexError(error)
    #print "Exit %s" % sys._getframe().f_code.co_name

def get_file_reader(myfile):
    """Get the file reader pointer"""
    #print "Enter %s" %sys._getframe().f_code.co_name
    try:
        with open(myfile, 'rb') as f:
            reader = csv.reader(f)
            lines = list(reader)
    except IOError as error:
        print "Unable to open %s file with error %s" % (myfile, error)
        raise IOError(error)
    except Exception as error:
        print "Unexpected Error: %s" % error
        raise Exception("Unexpected Error:", error)
    #print "Exit %s" % sys._getframe().f_code.co_name
    return lines 

def get_file_writer(outfile):
    """get the file writer pointer"""
    #print "Enter %s" % sys._getframe().f_code.co_name
    try:
        filewriter = open(outfile, 'w')
    except IOError as error:
        print "Unable to open %s file with error %s" % (outfile, error)
        raise IOError(error)
    except Exception as error:
        print "Unexpected Error:" % error
        raise Exception("Unexpected Error:", error)
    #print "Exit %s" % sys._getframe().f_code.co_name
    return filewriter 

def find_absent_value(filewriter, lines1, lines2):
    for line1 in lines1:
       found = False
       for line2 in lines2:
           if (line1[0].strip() == line2[0].strip()):
               found = True
               #break out of for loop
               break
       if (found == False):
           print "writing out line %s" % line1
           filewriter.write(line1[0].strip())
           filewriter.write("\n")
 
def dedup_files():
    lines1 = get_file_reader(file1)
    lines2 = get_file_reader(file2)
    
    filewriter = get_file_writer("notinsecondfile.txt")
    find_absent_value(filewriter, lines1, lines2)
    
    filewriter = get_file_writer("notinfirstfile.txt")
    find_absent_value(filewriter, lines2, lines1)
    
def main():
    """Start script to tranpose csv file"""
    
    #print "\n\n~~~~~~~~~~~~~~~~~~~~~~~START PROGRAM %s~~~~~~~~~~~~~~~~~~~~~~~~~~~~", __file__)
    try:
        get_usr_input()
    except Exception as error:
        print "Exception caught: ", error
        print "Usage: %s %s %s %s" % (__file__, "<file1>", "<file2>")
        print "EX: %s %s %s %s" % (__file__, "./file1.txt", "file2.txt")
        exit(1)

    try:
        dedup_files()
    except Exception as error:
        print "Exception caught: ", error
        exit(1)
    #print "\n~~~~~~~~~~~~~~~~~~~~~~~END PROGRAM %s~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n", __file__)

#main script starts here
main()
