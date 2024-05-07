# 获取脚本路径
script_path <- normalizePath(sub("^--file=(.*)", "\\1",commandArgs()[9]))
print(dirname(script_path))
