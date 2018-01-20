# copy-paste-vim

Description:
------------

While participating in Competitive Programming Contests, people usually have
a pre-existing set of code templates which they utilize while solving problems.
However, one can only submit a single source file which means that people will
have to copy code from other directories.

Doing this is tedious. That is why I have created this plugin via which you
can lift off code from your libraries by merely specifying the file name.

Setup:
------

1. Go to your home directory and create a directory called ".algorithms"
2. Put all your source files in this directory.
3. Go to ~/.vim/plugin
4. If this directory doesn't exist, make it.
5. Clone this repository there.
6. In the file, go to line 71 and replace my directories name with yours.
7. Oh yeah, most importantly, your version of vim should support python3. 

Usage:
------

Initially when you open a cpp file, your buffer should look something like this:

![initial file](https://github.com/Vrroom/copy-paste-vim/blob/master/images/init.png "In the beginning...")

Then you need to start a new section by typing \*{:

![in the process](https://github.com/Vrroom/copy-paste-vim/blob/master/images/adding.png "adding references to useful files")

And now when you close the brace by typing }\*, you will get:

![final image](https://github.com/Vrroom/copy-paste-vim/blob/master/images/end.png "finally...")

Lastly, the files which you are importing should have a comment
which looks like this:

// requires : \<vector\> \<queue\> \<iostream\>

