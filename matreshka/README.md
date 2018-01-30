matreshka
=========

[![Build Status](https://travis-ci.org/reznikmm/matreshka.svg?branch=master)](https://travis-ci.org/reznikmm/matreshka)

> Matreshka is Ada framework to develop information systems

The framework includes:

 * League - a rich set of reusable core components to develop Ada applications.
Its main purpose is to provide a high level abstraction tool for localization,
internationalization and globalization of applications, as well as a portable
interface to different operating systems. It contains many other useful
features, among them advanced calendrical calculations, regular expressions,
and JSON support to process and generate data in JSON format; 

 * XML processor - provides the capability of manipulating XML streams and
   documents; including:

   - SAX reader to read XML streams and documents; it supports XML1.0 (Fifth
     Edition), XML1.1 (Second Edition), Namespaces in XML and XML Base
     specifications;
   - SAX writer to generate XML streams and documents from application;
   - DOM API to process XML documents 0.8;
   - XML Catalogs resolver;
   - Markup Templates Engine to process XML templates and generates XML
     or HTML/XHTML output 0.6. 

 * Web framework
 
   - standalone application server - SpikeDog implemented over AWS (Ada Web
     Server) with Servlet API 0.7
   - the FastCGI module assists with developing server side applications
     completely in Ada and using them with standard HTTP servers. (demo).
   - the SOAP module provides implementation of SOAP 1.2 protocol specification
     and assists in developing Web Services in Ada. This module includes
     implementation of standard security services: The WS-Security module
     provides SOAP message Security 1.1 (WS-Security 2004) and Web Service
     security: Username Token Profile 1.1.
   - WSDL to Ada translator.
   - Ada to JavaScript translator and run-time library. 

 * SQL database access provides a simple generic API for accessing SQL
   databases. Supported databases include:

   - MySQL is the world's most popular open source database software;
   - Oracle is a well known commercial database management system;
   - PostgreSQL is a powerful, open source object-relational database system;
   - SQLite3 is a in-process library that implements a self-contained,
     serverless, zero-configuration, transactional SQL database engine;
   - Firebird is a relational database offering many ANSI SQL standard
     features that runs on Linux, Windows, and a variety of Unix platforms. 

 * Ada Modeling Framework provides implementation of OMG's Meta Object
   Facility (MOF) written completely in Ada. Extension modules are provided
   to assist in the analysis and modification of:

   - UML models and their extensions:
      + MOF Extensions to support metamodeling
      + OCL models
      + UML Testing Profile to support Model-Driven Testing 
   - Diagram Definition 

## Install

### Dependencies
You need GNAT and gprbuild to build Matreshka from sources.

Some optional packages are used by matreshka

 * AWS, required to build SpikeDog Application Server
 * ASIS, required to build a2js
 * MySQL, PostgreSQL, SQLite3, Oracle client libraries are required to build
   corresponding database driver
 * Valgrind, nodejs, requirejs, js-beautify are reuired to run tests


### Linux and other POSIX environment

To install Matreshka unpack its source code archive and run
```
make all install
```
Automatic configuration utility will be build and run to configure Matreshka
to meet your machine and operating system.


### Windows 32bit

On Windows system you need 'make', 'install' and a few other commands.
The easiest way to get them is to install
[​Make](http://gnuwin32.sourceforge.net/packages/make.htm) and
[​CoreUtils](http://gnuwin32.sourceforge.net/packages/coreutils.htm)
packages from GnuWin32 port.
Another option - install MinGW or Cygwin environment.


### Windows 64bit

On Windows 64 bits the only 'working' compiler (capable to run gprbuild) is
one of ​[msys2](https://msys2.github.io/) distribution.
To run Matreshka on Windows 64:

 * Download and install msys2 as described on ​https://msys2.github.io/
 * Install Ada compiler `pacman -S mingw-w64-gcc-ada
 * Now you need to replace unworking *.dll.a with corresponding dll.
   Do this in msys2 console:

```
adalib=$(dirname `gcc -print-libgcc-file-name`)/adalib
bin_dir=$(dirname `which gcc`)
rm -f ${adalib}/libgna{t,rl}-6.dll.a
cp ${bin_dir}/libgna{t,rl}-6.dll ${adalib}/
```

To install gprbuild setup our repository with precompiled packages:
```
echo [ci.mingw] >> /etc/pacman.conf
echo SigLevel = Optional >> /etc/pacman.conf
echo Server = https://dl.bintray.com/reznikmm/msys2/ >> /etc/pacman.conf
```

Install gprbuild-gpl (and asis if you like a2js):
```
pacman -S mingw-w64-gprbuild-gpl mingw-w64-asis
```

Continue with
```
make all install
```


### Mac OS

You may use GNAT GPL or
​[GCC from sf.net](https://sourceforge.net/projects/gnuada/files/GNAT_GCC%20Mac%20OS%20X/6.1.0/native-2016/).

On Mac OS system you need "Command Line Tools" installed. You can install this
from Xcode menu > Preferences > Downloads or, alternatively, there are
stand-alone installation packages
 * for ​[Mountain Lion (10.8)](https://developer.apple.com/downloads/index.action?=Command%20Line%20Tools%20%28OS%20X%20Mountain%20Lion%29)
 * for ​[Mavericks (10.9)](https://developer.apple.com/downloads/index.action?=Command%20Line%20Tools%20%28OS%20X%20Mavericks%29).


### Advanced installation

Sometimes, it is needed to have more control over configuration and build
of Matreshka. One example is use Matreshka on Windows, where detection
of non-standard libraries is problematic. Another example is binary packages
supporters.

So, build of Matreshka consists from several steps:

 * build of configuration utility;
 * start configuration utility;
 * package build;
 * package installation.


#### Build of configuration utility

Configuration utility can be built by using
```
make config
```

#### Start configuration utility

Execution of configuration utility in its simplest form looks like:
```
./configure
```

This is exactly what default make target do, so there is no reasons to use it.

Configuration utility allows to specify several additional parameters
all of them are reported by
```
./configure --help
```

Below is small example of manual execution of configuration utility to install
Matreshka in specified directory and to lookup SQLite's libraries
in the specified directory on Windows:
```
configure.exe --prefix=C:\Matreshka --with-sqlite3-libdir=C:\Matreshka\lib
```

It is possible to disable build of some Matreshka's modules. For example,
to disable AMF module run configuration utility with --disable-amf switch:
```
./configure --disable-amf
```

#### Build of Matreshka

To build Matreshka after manual configuration it is sufficient to run
```
make
```

Several make's variables can be used to adjust build process:

 * SMP_MFLAGS can be used to utilize several CPUs to compile Matreshka;
 * GNAT_OPTFLAGS can be used to pass additional user defined switches
   for compiler.

#### Installation of Matreshka

And to install Matreshka:
```
make install
```
Install target is used DESTDIR environment variable to adjust root directory,
it is very useful for binary packages supporters.

## Usage

Use corresponding project file for instance

```
with "matreshka_league";
project My_Project is

end My_Project;
```

See some examples in ```examples``` directory.

Other examples could be found on the site:
 * [Strings](https://forge.ada-ru.org/matreshka/wiki/League/UniversalString)
 * [Codecs](https://forge.ada-ru.org/matreshka/wiki/League/TextCodec)
 * [Text translator](https://forge.ada-ru.org/matreshka/wiki/League/Translator)
 * [String Vectors](https://forge.ada-ru.org/matreshka/wiki/League/UniversalStringVector)
 * [Settings](https://forge.ada-ru.org/matreshka/wiki/League/Settings)
 * [Calendar](https://forge.ada-ru.org/matreshka/wiki/League/Calendar)
 * [Regular Expressions](https://forge.ada-ru.org/matreshka/wiki/League/Regexp)
 * [XML SAX](https://forge.ada-ru.org/matreshka/wiki/XML/SAX)
 * [XML Engine](https://forge.ada-ru.org/matreshka/wiki/XML/Templates)
 * [Spikedog](https://forge.ada-ru.org/matreshka/wiki/Web/Spikedog)
 * [Database Access](https://forge.ada-ru.org/matreshka/wiki/SQL)
 * [UML](https://forge.ada-ru.org/matreshka/wiki/AMF)

## Maintainers
* [@Vadim Godunko](https://github.com/godunko).
* [@Maxim Reznik](https://github.com/reznikmm).

## Contribute

Feel free to dive in!
[Open an issue](https://github.com/reznikmm/matreshka/issues/new) or submit PRs.

## License

[BSD](LICENSE) © Vadim Godunko