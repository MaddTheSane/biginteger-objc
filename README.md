# biginteger-objc

The BigInteger class implements immutable arbitrary-precision integers. It provides methods to perform usual arithmetic operations, as well as modular arithmetic, GCD calculation, primality testing, prime generation, and a few other miscellaneous operations.


## Project overview

The Xcode project contains 4 targets:

- *BigInteger* is a Mac OS X command line application that performs unit testing of the class source code. You should select this target for common developpement tasks.
- *BigInteger-iOS* compiles the iOS version of the static library.
- *BigInteger-MacOSX* compiles the Mac OS X version of the static library.
- *UniLib* is a shell script that compiles the library for iOS, iOS Simulator and Mac OS X architectures (both 32 and 64 bits), and then pack them into a fat library.

## Building

Open the BigInteger.xcodeproj file with Xcode, select the UniLib target and compile. After the build succeeds, you'll find the BigInteger.h, libBigInteger-iOS.a and libBigInteger-MacOSX.a files in the ./build directory.

## Documentation

The BigInteger class documentation is written with LaTeX. The source files and a compiled PDF version is available in the ./documentation directory.