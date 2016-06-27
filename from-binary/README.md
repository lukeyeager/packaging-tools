Build a source package (for PPA upload) from a binary package.

This is pretty hacky - it deconstructs the package and creates a fake source package whose "source" consists of the prebuilt binaries in the original binary package.
