function! s:SshAdd(...)
  if $SSH_AGENT_PID == ''
    for _ in split(system('ssh-agent'), "\n")
      if _ !~ '^SSH_'
        continue
      endif
      let kv = split(split(_, ";")[0], "=")
      exe printf("let $%s = '%s'", kv[0], kv[1])
    endfor
  endif
  if a:0 > 0
    for _ in a:000
      exe printf('!ssh-add %s', shellescape(fnamemodify(_, ':p')))
    endfor
  else
    !ssh-add
  endif
endfunction

command! -nargs=* -complete=file SshAdd call s:SshAdd(<f-args>)
