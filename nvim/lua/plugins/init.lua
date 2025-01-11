return {
  -- { 'bart-jaskulski/note.nvim', dev = true, config = true },
  {
    'bart-jaskulski/a.nvim',
    dev = true,
    enabled = false,
    opts = {
      patterns = {
        php = {
          source = "src/{}.php",
          unit = "tests/{}Test.php",
          integration = "tests/Integration/{}Test.php",
          feature = "tests/Feature/{}Test.php"
        }
      }
    }
  },
  { 'phpactor/phpactor', enabled = false, ft = 'php', build = 'composer install --no-dev -o' },
}
