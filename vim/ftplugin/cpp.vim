setlocal sw=2 sts=2

nnoremap <buffer> <leader>b :w<bar>execute '!g++ % -o %:r -std=gnu++20 ' . g:gcc_compile_flag<CR>
nnoremap <buffer> <leader>r :!./%:r<CR>
command Codeforces %d_<bar>0r ~/CompetitiveProgramming/templates/main.cpp<bar>15,101fo<bar>111zz
ca Hash w !cpp -dD -P -fpreprocessed \| tr -d '[:space:]' \| md5sum \| cut -c-6
