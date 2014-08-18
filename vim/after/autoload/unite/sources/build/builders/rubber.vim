"=============================================================================
" FILE: rubber.vim
" AUTHOR:  Tatsuhiro Ujihisa <ujihisa at gmail.com>
" Last Modified: Sat Mar  9 18:01:03 PST 2013
"
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

" Variables  "{{{
call unite#util#set_default('g:unite_builder_rubber_command', 'rubber')
"}}}

function! unite#sources#build#builders#rubber#define() "{{{
  return executable(g:unite_builder_rubber_command) ?
        \ s:builder : []
endfunction "}}}

let s:builder = {
      \ 'name': 'rubber',
      \ 'description': 'rubber builder for ebuild files',
      \ }

function! s:builder.detect(args, context) "{{{
  return 1
endfunction"}}}

function! s:builder.initialize(args, context) "{{{
  let arg = a:args
  return g:unite_builder_rubber_command . ' ' . arg
endfunction"}}}

function! s:builder.parse(string, context)
  if empty(a:string)
    return {}
  endif
  if a:context.source__builder_args[0] ==# 'manifest'
    return s:_parse_manifest(a:string, a:context)
  elseif a:context.source__builder_args[0] ==# 'full'
    return s:_parse_full(a:string, a:context)
  else
    return {'type': 'message', 'text': printf('# %s', a:string)}
  endif
endfunction

function! s:_parse_manifest(string, context)
  return {'type': 'message', 'text': printf('  %s', a:string)}
endfunction

function! s:_parse_full(string, context)
  if a:string == 'rubber scours the neighborhood...'
    return {}
  endif
  return {'type': 'message', 'text': printf('* %s', a:string)}
endfunction

" vim: foldmethod=marker
