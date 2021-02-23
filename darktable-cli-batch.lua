local path = require("path")

local in_path = "."
local pattern = ".+%.jpe?g$"
local xmp_paths = {"preset1.xmp", "preset2.xmp"}
local out_path = "output"

local abs_in_path = path.ensure_dir_end(path.fullpath(in_path))
local abs_out_path = path.fullpath(out_path)

path.each(abs_in_path, function(p, mode)
  if mode == "file" then
    if string.find(p, abs_out_path, 1, true) == nil then
      if string.find(p, pattern) then
	for _, xmp_path in ipairs(xmp_paths) do
	  local out_file_name = string.format("%s_%s%s", path.basename(path.splitext(p)), path.basename(path.splitext(xmp_path)), path.extension(p))

	  os.execute(string.format("darktable-cli %s %s %s", p, xmp_path, path.join(abs_out_path, out_file_name)))
	end
      end
    end
  end
end, {
param = "fm";
recurse = true;
})
