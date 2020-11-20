local lfs = require("lfs")
local path = require("path")

local in_path = "."
local pattern = ".+%.jpe?g$"
local xmp_paths = {"preset1.xmp", "preset2.xmp"}
local out_path = "output"

local abs_in_path = path.fullpath(in_path)
local abs_out_path = path.fullpath(out_path)

function applyXmps(dir_path)
  for file_name in lfs.dir(dir_path) do
    local file_path = path.join(dir_path, file_name)
    local attrs = lfs.attributes(file_path)

    if attrs.mode == "file" then
      if string.find(file_name, pattern) then
	for _, xmp_path in ipairs(xmp_paths) do
	  local out_file_name = string.format("%s_%s%s", path.basename(path.splitext(file_name)), path.basename(path.splitext(xmp_path)), path.extension(file_name))
	  os.execute(string.format("darktable-cli %s %s %s", file_path, xmp_path, path.join(out_path, out_file_name)))
	end
      end
    else
      if file_name ~= "." and file_name ~= ".." and abs_out_path ~= file_path then
	applyXmps(file_path)
      end
    end
  end
end

applyXmps(abs_in_path)
