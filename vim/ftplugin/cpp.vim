setlocal sw=4 sts=4

nnoremap <buffer> <leader>b :w<bar>execute '!g++ % -o %:r -std=c++17 ' . g:gcc_compile_flag<CR>
nnoremap <buffer> <leader>r :!./%:r<CR>
command Codeforces %d_<bar>0r ~/CompetitiveProgramming/templates/main.cpp<bar>15,101fo<bar>111zz

