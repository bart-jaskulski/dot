function fish_user_key_bindings
  fish_default_key_bindings -M
  #
  # # Vi mode
  fish_vi_key_bindings
  #

  bind alt-k -M insert up-or-search
  bind alt-j -M insert down-or-search

  bind alt-f -M insert accept-autosuggestion
  bind alt-l complete

  # bind tab -M insert fzf_smart_triggers

  # fzf --fish | source
  # Ctrl+R for history search using fzf
  # bind \cr _fzf_search_history
end
