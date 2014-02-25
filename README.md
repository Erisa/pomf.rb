simple-pomf-uploader
====================

Made to handle piped in data as well as file args.

# Usage

To upload 'file.txt', you would type `./pomf file.txt`

The real magic comes in with pipes though. For example, if you wanted to paste
your uptime for someone you could do `uptime | ./pomf`. Or perhaps you have an
image on your clipboard and want to upload it... Only a `xclip -o | ./pomf`
away.

# Why make another?

The other command line uploaders I looked at on the tools page, notably the
Simple Bash Uploader, did not handle pipes at all. I wanted pipes. I also wanted
it to get extensions right from pipes which was another task to itself.


# What's wrong with this one?

Requires ruby (not a default install on many distros) and doesn't have highly
informative error messages, multi-file uploading, or anything else complicated.

The code for figuring out extensions is also hacky, but I'm not sure there's a
better solution.
