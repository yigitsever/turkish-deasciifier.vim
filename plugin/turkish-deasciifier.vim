" turkish-deasciifier.vim
" Author: Yigit Sever <https://yigitsever.com>
" Original Author: Cumhur Korkut <http://joom.im/>

if exists("g:loaded_turkish_deasciifier")
    finish
endif
let g:loaded_turkish_deasciifier = 1

if !exists("g:turkish_deasciifier_path")
    let g:turkish_deasciifier_path = 'turkish-deasciify'
endif

" Intelligently changes characters to Turkish variants
function! TurkishDeasciify(type = '') abort
    if a:type == ''
        set opfunc=TurkishDeasciify
        return 'g@'
    endif

    " set everything aside
    let sel_save = &selection
    let reg_save = getreg('"')
    let cb_save = &clipboard
    let visual_marks_save = [getpos("'<"), getpos("'>")]

    try
        set clipboard= selection=inclusive
        " the motion was over '[,'], yank that using whatever motion was
        let commands = #{line: "'[V']y", char: "`[v`]y", block: "`[\<c-v>`]y"}
        silent execute 'noautocmd keepjumps normal! ' .. get(commands, a:type, '')

        let res = system("echo " . shellescape(getreg('"')) . " | " . g:turkish_deasciifier_path)
        let res = trim(res)
        call setreg('"', res, getregtype('"'))

        " paste the result back, doing it like this prevents dumb whitespaces
        if a:type == "char"
            normal! `[v`]""p
        elseif a:type == "line"
            normal! '[V']""p
        else
            normal! `[\<c-v>`]""p
        end
    finally
        " put everything in it's place
        call setreg('"', reg_save)
        call setpos("'<", visual_marks_save[0])
        call setpos("'>", visual_marks_save[1])
        let &clipboard = cb_save
        let &selection = sel_save
    endtry
endfunction

" Change characters to Turkish variants, useful to clean up after deasciifier
function! TurkishDeasciifyForce(type = '') abort
    if a:type == ''
        set opfunc=TurkishDeasciifyForce
        return 'g@'
    endif

    let sel_save = &selection
    let reg_save = getreg('"')
    let cb_save = &clipboard
    let visual_marks_save = [getpos("'<"), getpos("'>")]

    let s:ascii_turkish = [['g','ğ'],['G','Ğ'],['c','ç'],['C','Ç'],['s','ş'],['S','Ş'],['u','ü'],['U','Ü'],['o','ö'],['O','Ö'],['i','ı'],['I','İ']]
    try
        set clipboard= selection=inclusive
        let commands = #{line: "'[V']y", char: "`[v`]y", block: "`[\<c-v>`]y"}
        silent execute 'noautocmd keepjumps normal! ' .. get(commands, a:type, '')
        for pair in s:ascii_turkish
            call setreg('"', substitute(getreg('"'), '\C' . pair[0], pair[1], 'g'), getregtype('"'))
        endfor

        if a:type == "char"
            normal! `[v`]""p
        elseif a:type == "line"
            normal! '[V']""p
        else
            normal! `[\<c-v>`]""p
        end
    finally
        call setreg('"', reg_save)
        call setpos("'<", visual_marks_save[0])
        call setpos("'>", visual_marks_save[1])
        let &clipboard = cb_save
        let &selection = sel_save
    endtry
endfunction

" To switch everything back to Ascii
function! TurkishAsciify(type = '') abort
    if a:type == ''
        set opfunc=TurkishAsciify
        return 'g@'
    endif

    let sel_save = &selection
    let reg_save = getreg('"')
    let cb_save = &clipboard
    let visual_marks_save = [getpos("'<"), getpos("'>")]

    let s:turkish_ascii = [['ğ','g'],['Ğ','G'],['ç','c'],['Ç','C'],['ş','s'],['Ş','S'],['ü','u'],['Ü','U'],['ö','o'],['Ö','O'],['ı','i'],['İ','I'],['â','a'],['Â','A'],['û','u'],['Û','U'],['î','i'],['Î','I']]
    try
        set clipboard= selection=inclusive
        let commands = #{line: "'[V']y", char: "`[v`]y", block: "`[\<c-v>`]y"}
        silent execute 'noautocmd keepjumps normal! ' .. get(commands, a:type, '')
        for pair in s:turkish_ascii
            call setreg('"', substitute(getreg('"'), '\C' . pair[0], pair[1], 'g'), getregtype('"'))
        endfor

        if a:type == "char"
            normal! `[v`]""p
        elseif a:type == "line"
            normal! '[V']""p
        else
            normal! `[\<c-v>`]""p
        end
    finally
        call setreg('"', reg_save)
        call setpos("'<", visual_marks_save[0])
        call setpos("'>", visual_marks_save[1])
        let &clipboard = cb_save
        let &selection = sel_save
    endtry
endfunction
