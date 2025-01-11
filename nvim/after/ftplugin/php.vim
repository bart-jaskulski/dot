" builtin php syntax highlighing customization
let g:php_sql_query = 1
let g:php_htmlInStrings = 2
let g:php_parent_error_close = 1
let g:php_parent_error_open = 1
let g:php_folding = 0

" Add class methods abbreviations similar to phpstorm
iabbrev pubf public function
iabbrev prif private function
iabbrev prof protected function
iabbrev pubsf public static function
iabbrev prisf private static function
iabbrev prosf protected static function

iabbrev thr throw new

iabbrev __c public function __construct(

iabbrev dst declare(strict_types=1);
