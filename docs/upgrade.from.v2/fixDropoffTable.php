#!/usr/bin/php
<?PHP

if ( count($argv) < 2 ) {
  printf("
  usage:
  
   %s <zendto preference file> {email address}
  
   The zendto preference file path should be canonical, not relative.

",$argv[0]);
  return 0;
}

if ( ! preg_match('/^\/.+/',$argv[1]) ) {
  echo "ERROR:  You must provide a canonical path to the preference file.\n";
  return 1;
}

include $argv[1];
require_once(NSSDROPBOX_LIB_DIR."Smartyconf.php");
include_once(NSSDROPBOX_LIB_DIR."NSSDropoff.php");

if ( $theDropbox = new NSSDropbox($NSSDROPBOX_PREFS) ) {
      if (SqlBackend === 'SQLite') {
        $qResult = $theDropbox->database()->database->arrayQuery(
                      sprintf("SELECT rowID,* FROM dropoff"),
                      SQLITE_ASSOC
                    );
      } else {
        $res = $theDropbox->database()->database->query(
                   sprintf("SELECT rowID,* FROM dropoff"));
        $i = 0;
        $qResult = array();
        while ($line = $res->fetch_array()) {
          $qResult[$i++] = $line;
        }
      }

      echo "BEGIN TRANSACTION;\n";
      foreach ($qResult as $q) {
        echo "INSERT INTO dropoff\n";
        echo "( rowID, claimID, claimPasscode, authorizedUser, senderName, senderOrganization, senderEmail, senderIP, confirmDelivery, created, note )\n";
	echo sprintf("VALUES (%d,'%s','%s','%s','%s','%s','%s','%s','%s','%s','%s');\n",
             $q[rowID],
             sqlite_escape_string($q[claimID]),
             sqlite_escape_string($q[claimPasscode]),
             sqlite_escape_string($q[authorizedUser]),
             sqlite_escape_string($q[senderName]),
             sqlite_escape_string($q[senderOrganization]),
             sqlite_escape_string($q[senderEmail]),
             sqlite_escape_string($q[senderIP]),
             sqlite_escape_string($q[confirmDelivery]),
             sqlite_escape_string($q[created]),
             sqlite_escape_string($q[note]));
     }
     echo "COMMIT;\n";
}

?>
