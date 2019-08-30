let s:session = {}

function! snips#get_session()
  return s:session
endfunction

function! snips#expandable_or_jumpable()
  return s:expandable() || s:jumpable()
endfunction

function! snips#expand_or_jump()
  let l:virtualedit = &virtualedit
  let &virtualedit = 'onemore'

  if s:expandable()
    let l:target = snips#snippet#get_snippet_with_prefix_under_cursor(&filetype)
    let s:session = snips#session#new(l:target['prefix'], l:target['snippet'])
    call s:session.expand()
  endif

  if s:jumpable()
    call s:session.jump()
  endif

  let &virtualedit = l:virtualedit
endfunction

function! s:expandable()
  return !empty(snips#snippet#get_snippet_with_prefix_under_cursor(&filetype))
endfunction

function! s:jumpable()
  return !empty(s:session) && s:session.jumpable()
endfunction

