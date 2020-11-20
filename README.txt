darktable-cli-batch

darktable-cli-batch is a Lua script for batch application of xmp files to multiple photos. 

To use it you need to install Lua (https://www.lua.org/) and then change the variables at the top of the darktable-cli-batch.lua file:

in_path - path to the directory where the input files are located
pattern - Lua pattern to which the input file paths must match 
xmp_paths - paths to xmp files
output_path - path where the modified files will be written

After that you can run the script:
$ lua darktable-cli-batch.lua

