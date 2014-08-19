#!/usr/bin/php

<?php
require("lib/sql_class.inc");
$sql_obj = new sql_query;
$sql_obj->set_vars("localhost","root","ferreira","stress_test");

date_default_timezone_set('GMT');
$start_d = new DateTime($argv[1]);
$end_d = new DateTime($argv[2]);
$interval = new DateInterval('PT10S');
$range = new DateInterval('PT60S');
#$query_array = [];

while ($start_d <= $end_d) {
	$bk_d = clone $start_d;
	$bk_d->sub($range);
	$start = $start_d->format('Y-m-d H:i:s');
	$bk = $bk_d->format('Y-m-d H:i:s');
	$query_array[] = " select 
						'$start' as \"when\" ,
						(select count(*) from requests
							where requests.created_at between '$bk' and '$start') as \"qtd_request\",
						(select count(*) from responses
							where responses.created_at between '$bk' and '$start') as \"qtd_response\",
						(select avg(tot) from responses
							where responses.created_at between '$bk' and '$start') as \"avg_response\",
						(select max(tot) from responses
							where responses.created_at between '$bk' and '$start') as \"max_response\" ";


	$start_d->add($interval);
}
$query = implode(" union \n ", $query_array);
#print "$query \n";

$sql_obj->query($query);
$sql_obj->tablemount();

foreach ($sql_obj->result as $row) {
	$when[] = $row->when;
	$qtd_request[] = $row->qtd_request;
	$qtd_response[] = $row->qtd_response;
	$avg_response[] = $row->avg_response;
	$max_response[] = $row->max_response;
}

$w = implode(";", $when);
$req = implode(";", $qtd_request);
$resp = implode(";", $qtd_response);
$avg_resp = implode(";", $avg_response);
$max_resp = implode(";", $max_response);

print "$w\n$req\n$resp\n$avg_resp\n$max_resp";
?>



