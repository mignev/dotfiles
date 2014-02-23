#!/usr/bin/env python

#-----------------------------------------------------------------------------
# The MIT License
# 
# Copyright (c) 2009, 2010 Patrick Mueller
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# run a command whenever a file changes
#-----------------------------------------------------------------------------

import os
import sys
import time
from subprocess import Popen
from datetime import datetime
from optparse import OptionParser
from fnmatch import fnmatch

ProgramName    = os.path.basename(sys.argv[0])
ProgramVersion = "0.2"

Verbose = False

#-----------------------------------------------------------------------------
# verbose log
#-----------------------------------------------------------------------------
def vlog(message):
    if not Verbose: return
    log(message)

#-----------------------------------------------------------------------------
# log a message
#-----------------------------------------------------------------------------
def log(message):
    timeStamp = datetime.now().isoformat(" ")[:19]
    print "%s %s: %s" % (ProgramName, timeStamp, message)

#-----------------------------------------------------------------------------
# more help
#-----------------------------------------------------------------------------
def moreHelp(parser):
    
    parser.print_help()

    print """
This program is designed to be run continuously, monitoring a set of files
and/or directories for any changes to the files.  When a file being monitored
changes, the specified command will be run.

When monitoring directories, you can specify a set of matching files to be
checked using the -m option. The -m option may be used more than once. It uses
"glob" syntax; this is 'wildcard' expansion as available from the
command-line. You will likely need to escape the match value to prevent your
shell from expanding it. see http://docs.python.org/library/fnmatch.html for
more information on "glob" expansion."""

    sys.exit()

#-----------------------------------------------------------------------------
# parse command-line
#-----------------------------------------------------------------------------
def parseCommandLine():
    version = "%prog 1.0"
    usage   = """usage: %prog [options] command fileOrDir fileOrDir ...

   run a command when one of the specified files changes.  Directories may 
   also be specified.  The command will likely need to be quoted."""
   
    parser = OptionParser(usage=usage)

    parser.add_option("-c", "--chime", 
        dest    = "chime",
        action  = "store",
        type    = "int",
        default = 60,
        help    = "seconds before a (visual) chime (default: %default)", 
    )

    parser.add_option("-i", "--interval", 
        dest    = "interval",
        action  = "store",
        type    = "int",
        default = 3,
        help    = "seconds before checking for changes (default: %default)", 
    )

    parser.add_option("-m", "--match", 
        dest   = "matches",
        action = "append",
        help   = "only process matching files (use glob syntax)", 
    )

    parser.add_option("-v", "--verbose", 
        dest    = "verbose",
        action  = "store_true",
        default = False,
        help    = "be chatty", 
    )

    parser.add_option("-V", "--version", 
        dest    = "version",
        action  = "store_true",
        default = False,
        help    = "print version", 
    )

    parser.add_option("-x", "--extra-help", 
        dest    = "moreHelp",
        action  = "store_true",
        default = False,
        help    = "display additional help", 
    )

    (options, args) = parser.parse_args()
    
    if options.moreHelp: moreHelp(parser)
    if options.version: 
        print "%s %s" % (ProgramName, ProgramVersion)
        sys.exit()

    if not len(args): 
        parser.print_help()
        sys.exit()
    
    if None == options.matches:   options.matches = ["*"]
    if 0 == len(options.matches): options.matches = ["*"]
    
    return (options, args)

#-----------------------------------------------------------------------------
# class to collect file info
#-----------------------------------------------------------------------------
class FileInfoCollection:
    
    # constructor
    def __init__(self, paths, matches):
        self._files = {}

        vlog("building new file info collection")
        for path in paths:
            vlog("   adding path: %s" % path)
            path = os.path.abspath(path)
            self._addSpec(path, matches)
        
    # return the mtime of the specified file
    def getmtime(self, path):
        if path not in self._files: return 0
        return self._files[path]

    # return the list of files in this collection
    def files(self):
        return self._files.keys()
        
    # add files from specification
    def _addSpec(self, path, matches):
        if not os.path.exists(path):
            vlog("      path does not exist: %s" % path)
            return
            
        if os.path.isdir(path):
            vlog("      collecting file names in directory: %s" % path)
            fileNames = self._getFilesInDir(path, matches)
            for fileName in fileNames:
                if fileName not in self._files:
                    vlog("         adding: %s" % fileName)
                    self._files[fileName] = os.path.getmtime(fileName)
            return
            
        if not os.path.isfile(path):
            vlog("      path is not a file or directory: %s" % path)
            return
            
        if path not in self._files:
            vlog("      adding: %s" % path)
            self._files[path] = os.path.getmtime(path)

    # add files from a directory
    def _getFilesInDir(self, path, matches, result=None):
        if None == result: result = []
        
        entries = os.listdir(path)
        for entry in entries:
            fullName = os.path.join(path, entry)
            
            if os.path.isdir(fullName):
                self._getFilesInDir(fullName, matches, result)
                continue
            
            if not os.path.isfile(fullName):
                continue
                
            for match in matches:
                if fnmatch(entry, match):
                    result.append(fullName)
                    
        return result

#-----------------------------------------------------------------------------
# main program
#-----------------------------------------------------------------------------
(options, args) = parseCommandLine()

#-----------------------------------------------------------------------------
# parse args
#-----------------------------------------------------------------------------
command = args[0]
files   = args[1:]

log("starting; break out of the program to exit")

#-----------------------------------------------------------------------------
# collect dates on files
#-----------------------------------------------------------------------------
oldFiles = FileInfoCollection(files, options.matches)
    
#-----------------------------------------------------------------------------
# get values from options
#-----------------------------------------------------------------------------
chimeCountDown = options.chime
interval       = options.interval
Verbose        = options.verbose

#-----------------------------------------------------------------------------
# enter infinite loop
#-----------------------------------------------------------------------------
while True:
    
    # sleep
    try:
        time.sleep(interval)
    except:
        sys.exit()
        
    # sound chime, if needed
    chimeCountDown -= interval
    if chimeCountDown < 0:
        chimeCountDown = options.chime
        log("chime")

    # collect dates on files
    newFiles = FileInfoCollection(files, options.matches)

    changed = False
    
    # compare before/after dates on files
    fileNames = set()
    fileNames = fileNames.union(newFiles.files())
    fileNames = fileNames.union(oldFiles.files())
    
    for fileName in fileNames:
        if oldFiles.getmtime(fileName) != newFiles.getmtime(fileName):
            vlog("file changed: %s" % fileName)
            changed = True
            break

    # if no changes, back to top of loop
    if not changed: 
        oldFiles = newFiles
        continue
    
    log("running command: %s" % command)
    process = Popen(command, shell=True)
    process.wait()
        
    # get the file info again so we don't trigger changes based on command
    oldFiles = FileInfoCollection(files, options.matches)