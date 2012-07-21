{literal}
<style type="text/css">
.pro_item {
padding:5px 0 5px 2px;
}
.pro_left {
float:left;
width:70px;
}
.pro_right {
float:left;
}
.pro_thumb {
width:64px;
height:64px;
padding:2px;
border:1px solid #ddd;
}
.pro_thumb img{
padding:0px;
}
.pro_details {
float:left;
width:325px;
margin:0 0 0 10px;
}
.pro_title h3 {
line-height:20px;
}
.pro_title h3 a,.pro_title h3 a:visited{
font-size:13px;
}
.pro_description {
margin:2px 0 0 0;
}
.pro_description p{
}
.pro_description p strong{
font-weight:normal;
}
.pro_price {
float:left;
background:#EDEDED;
border:1px solid #BABABA;
margin:5px 0 0 0;
padding:1px 2px;
width:64px;
text-align:center;
}
.pro_price p {margin:0;padding:0;}
.pro_price p a, .pro_price p a:visited{
color:#A61100;
font-size:11px;
font-weight:bold;
}
</style>
{/literal}

{php}
require_once('../libs/SimplePie.compiled.php');
$feed = new SimplePie();
$feed->set_feed_url('http://www.pligg.com/pro/rss.php');
$feed->init();
$feed->handle_content_type();

// Starting item
$start = 0;
// Number of items to display. 0 = all
$length = $this->_vars['product_count'];
 
function extract_unit($string, $start, $end){
	$pos = stripos($string, $start);
	$str = substr($string, $pos);
	$str_two = substr($str, strlen($start));
	$second_pos = stripos($str_two, $end);
	$str_three = substr($str_two, 0, $second_pos);
	$unit = trim($str_three); // remove whitespaces
	return $unit;
}

foreach ($feed->get_items($start,$length) as $item): {/php}
	<div class="pro_item">
		{php}
		$data = $item->get_description();
		
		$string_1 = '<img src="';
		$string_2 = '"';
		$info1 = extract_unit($data, $string_1, $string_2);
		
		$link = $item->get_link();
		$queryString = '';
		
		echo '<div class="pro_left">';
		echo '<div class="pro_thumb"><a href="' . $link . $queryString . '"><div style="text-align:center;"><img src="'. $info1 .'" /></div></a></div>';
		
		$string_5 = '<p>$';
		$string_6 = '</p>';
		$info3 = extract_unit($data, $string_5, $string_6);
		// Strip out HTML tags
		$info3 = strip_tags($info3); 
		echo '<div class="pro_price"><p><a href="' . $link . $queryString . '">$' .$info3 .'</a></p></div>';
		
		echo '</div>'; /* /.pro_left */
		
		echo '<div class="pro_right">';
		echo '<div class="pro_details">';
		echo '<div class="pro_title"><h3><a href="' . $link . $queryString . '">'. $item->get_title() .'</a></h3></div>';

		$string_3 = '<p>';
		$string_4 = '</p>';
		$info2 = extract_unit($data, $string_3, $string_4);
		// Strip out HTML tags
		$info1 = strip_tags($info1); 
		echo '<div class="pro_description"><p>' .$info2 .'</p></div>';
		echo '</div>'; /* /.pro_right */
		echo '</div><div style="clear:both;"> </div>';
	{/php}
	</div>	
{php} endforeach; {/php}