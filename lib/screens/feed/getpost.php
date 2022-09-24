<?php 
include 'connection.php';
include 'login.php';

$result =$db->query("SELECT post")

$list = array();
if ($result) {
    while($row = mysqli_fetch_assoc($result)) {
        $list[] = $row;
    }
    echo json_encode($list);
}