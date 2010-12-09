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
         require 'phar://' . __FILE__ . $classes[$cn];
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

   $mainClasses = array(___AVAILABLE_MAIN_CLASSES___);
   if (isset($argv[1]) && isset($mainClasses[strtolower($argv[1])])) {
      $mainClass = $mainClasses[strtolower($argv[1])];

      unset($argv[1]);
      $argv = array_values($argv);

      $_SERVER['argv'] = $argv;
      $GLOBALS['argv'] = $argv;

      exit(call_user_func(array($mainClass, 'main'), $argv));
   } else if ('___DEFAULT_MAIN_CLASS___' !== '___DEFAULT_MAIN_CLASS__' . '_') {
      exit(___DEFAULT_MAIN_CLASS___::main($argv));
   }
}
__HALT_COMPILER();
