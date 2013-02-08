#This file initialises logging of stdout to the access 
#log and tag changes to the blame log.
#It also sources environment variables for stomp
#connections from stomp.conf

require File.dirname(__FILE__) + '/logwrite'

$blamelog = Logger.new("/var/log/grabby-fe_blame.log")
$accesslog = Logger.new("/var/log/grabby-fe_access.log")
$blamelog.level = Logger::INFO
$blamelog.info("Starting Grabby-FE")
$stdout = Logwrite.new($accesslog, "stdout") 

