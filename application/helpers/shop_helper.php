<?php defined('BASEPATH') OR exit('No direct script access allowed');
function money($n){ return '$'.number_format((float)$n,2); }
function discount_percent($price,$old){
 $price=(float)$price; $old=(float)$old;
 return ($old>0 && $old>$price) ? (int)round((($old-$price)/$old)*100) : 0;
}
