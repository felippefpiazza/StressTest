#!/usr/bin/php

<?php
$when = $argv[1];
$start = $argv[2];
$end = $argv[3];

$counter = $start;
while ($counter <= $end) {
	$sec = 0;
	while($sec < 60) {
		$sec_fw = $sec + 10;
		print "select '$when:$counter:$sec',count(*)*6 from requests where created_at between '$when:$counter:$sec' and '$when:$counter:$sec_fw' union \n";
		$sec = $sec + 10;
	}
	$counter = $counter + 1;
}




