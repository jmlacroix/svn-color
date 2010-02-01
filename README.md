SETUP
====

Copy the whole svn function from the svn-color.sh file to your bash resource
file (mine is ~/.bash_profile).

Dont forget to refresh your bash_profile by sourcing it: source ~/.bash_profile

You're done. The svn function overrides the svn executable, which it call
directly from its full path.

You can disable colors at any time with the --nocol option.

TODO
====

- Add more svn functions for "status like" data output (rm, checkout, ...)
- Check/add zsh compatibility

COPYRIGHT
=======

Copyright (c) 2010 Jean-Michel Lacroix. See LICENSE for details.
