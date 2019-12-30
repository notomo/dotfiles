
function! s:update_package_json(path) abort
    let path = fnamemodify(a:path, ':p')
    let dir = fnamemodify(path, ':p:h')
    execute 'lcd' dir

    let lines = systemlist(['npm', 'outdated'])[1:]

    let latests = []
    for line in lines
        let latest = {}
        let splitted = split(line, '\v\s+')
        let latest.name = splitted[0]
        let latest.version = splitted[3]
        call add(latests, latest)
    endfor
    echomsg string(latests)

    execute 'tabedit' path
    let new_lines = []
    for latest in latests
        let target_pattern = printf('\v\s+"%s": "', escape(latest.name, '@'))
        let found_lnum = search(target_pattern)
        if found_lnum != 0
            let new_line = printf('"%s": "^%s"', latest.name, latest.version)
            call setline(found_lnum, new_line)
        endif
    endfor
endfunction

let s:target_package_json_path = 'path/to/package.json'
call s:update_package_json(s:target_package_json_path)
