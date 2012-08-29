<?php

include_once('Smarty.class.php');
$main_smarty = new Smarty;

include('config.php');
include(mnminclude.'html1.php');
include(mnminclude.'link.php');
include(mnminclude.'smartyvariables.php');

$vars = '';
check_actions('404Error', $vars);

define('pagename', '404'); 
$main_smarty->assign('pagename', pagename);

// sidebar
$main_smarty = do_sidebar($main_smarty);

// show the template
header( "HTTP/1.1 404 Not Found" );
$main_smarty->assign('tpl_center', $the_template . '/404error');
$main_smarty->display($the_template . '/pligg.tpl');
exit;
?>