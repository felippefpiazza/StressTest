<?php

class sql_query 
{
	var $DBHOST;//Host for connecting to
	var $DBUSER;//Mysql Username
	var $DBPASS;//Mysql Password
	var $DBNAME;//Your require Database


	function set_vars($host="localhost", $username="", $password="", $db="")
	{
		$this->DBHOST = $host;
		$this->DBUSER = $username;
		$this->DBPASS = $password;
		$this->DBNAME = $db;
	}

	function query($query)
	{
		// connecting, selecting database
		$sql_link = mysql_connect("$this->DBHOST","$this->DBUSER","$this->DBPASS")
		or print "Could not connect to database";

		// select the database
		mysql_select_db("$this->DBNAME") or print "Could not select database";

		// make the query
		$result = mysql_query($query);

		if (!$result)
		{
			return mysql_errno();
		}
		else
		{
			$this->result_raw = $result;
		}
	}

	function tableindex()
	{
		while ($fields = mysql_fetch_field($this->result_raw)) 
		{
			$colunas[] = $fields->name;
		}
		$this->columns = $colunas;
	}

	function tablemount()
	{
		while ($row = mysql_fetch_object($this->result_raw)) 
		{
			$return[] = $row;
		}
		$this->result=$return;
	}
}

?>
