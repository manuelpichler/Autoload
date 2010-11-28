#!/usr/bin/env php
<?php
spl_autoload_register(
   function($class) {
      static $classes = null;
      if ($classes === null) {
         $classes = array(
            ___CLASSLIST___
         );
      }
      $cn = strtolower($class);
      if (isset($classes[$cn])) {
         require 'phar://___PHAR___' . $classes[$cn];
      }
   }
);
if (isset($argv[0]) && __FILE__ === realpath($argv[0])) {
   ob_start();
   foreach (explode(PATH_SEPARATOR, get_include_path()) as $path) {
      if (substr($path, -5, 5) === '.phar') {
         include_once $path;
      }
   }
   ob_end_clean();
   exit(___MAIN_METHOD___($argv));
}
__HALT_COMPILER();
