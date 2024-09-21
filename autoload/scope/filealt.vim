vim9script
scriptencoding utf-8

import autoload 'scope/popup.vim'

export def File(path: string = null_string)
  var findpath = empty(path) ? getcwd() : path
  var filelist = glob(findpath .. '**/*', 0, 1)
  var files = []
  for file in filelist
      files->add({text: file})
  endfor
  popup.NewFilterMenu("File", files,
    (res, key) => {
      silent execute 'edit ' .. res.text
    },
    (winid, _) => {
      win_execute(winid, $"syn match FilterMenuLineNr '(\\d\\+)$'")
      hi def link FilterMenuLineNr Comment
    })
enddef

