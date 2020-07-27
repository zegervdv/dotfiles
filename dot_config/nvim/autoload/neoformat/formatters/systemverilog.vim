function! neoformat#formatters#systemverilog#enabled() abort
   return ['verible']
endfunction

function! neoformat#formatters#systemverilog#verible() abort
   return {
      \ 'exe': 'verilog_format',
      \ 'args': ['-', '--format_module_instantiations'],
      \ 'stdin': 1
      \ }
endfunction
