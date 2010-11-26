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

exit(___MAIN_METHOD___($argv));
__HALT_COMPILER();
