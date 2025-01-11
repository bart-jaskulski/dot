function fish_user_key_bindings
  fish_default_key_bindings -M
  #
  # # Vi mode
  # fish_vi_key_bindings --no-erase
  #

  bind \ek up-or-search
  bind \ej down-or-search

  bind \ef accept-autosuggestion
  bind \el complete

  # fzf --fish | source
  # Ctrl+R for history search using fzf
  # bind \cr _fzf_search_history
end
