message('library paths:\n', paste('... ', .libPaths(), sep='', collapse='\n'))
script_path <- normalizePath(sub("^--file=(.*)", "\\1",commandArgs()[9]))
script_pwd <- dirname(script_path)

chrome.portable = file.path(script_pwd,
'../../Portable/App/Chrome-bin/chrome.exe')

launch.browser = function(appUrl, browser.path=chrome.portable) {
    message('Browser path: ', browser.path)
    shell(sprintf('"%s" --app=%s', browser.path, appUrl))
}

shiny::runApp(script_pwd, launch.browser=launch.browser)