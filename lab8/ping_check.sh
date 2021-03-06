# Example of ping checker with output to InfluxDB
# Can be wrapped as a service and run in background
while true
do
  curl -i -XPOST 'http://192.168.56.103:8086/write?db=rtt' --data-binary "$(\
    fping google.com godaddy.com ttu.ee -C1 -q 2>&1 |\
    awk '{print "latency,dst="$1" rtt="$3}'\
  )" 1>/dev/null 2>/dev/null
  sleep 1
done
