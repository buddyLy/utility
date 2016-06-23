#!/bin/bash
IF=$1
if [ -z "$IF" ]; then
        IF=`ls -1 /sys/class/net/ | head -1`
fi
RXPREV=-1
TXPREV=-1
counter=0
maxcounter=10
rx_total=0
tx_total=0
echo "Listening $IF..."
while [ 1 == 1 ] ; do
        RX=`cat /sys/class/net/${IF}/statistics/rx_bytes`
        TX=`cat /sys/class/net/${IF}/statistics/tx_bytes`
        if [ $RXPREV -ne -1 ] ; then
                #let BWRX=$RX-$RXPREV
                let BWTX=($TX-$TXPREV)/1024
                #let BWRX=$RX-$RXPREV
                let BWRX=($RX-$RXPREV)/1024
                #echo $BWRX $BWTX | awk '{ rx = $1 / 1024 / 1024 ; tx = $2 / 1024 / 1024 ; prin        t "Received " rx "MB/s, Sent " tx "MB/s" }'
                #echo "Received: $BWRX B/s    Sent: $BWTX B/s"
                echo "Received: $BWRX KB/s    Sent: $BWTX KB/s"
        fi
        RXPREV=$RX
        TXPREV=$TX
        rx_total=$((rx_total+BWRX))
        tx_total=$((tx_total+BWTX))
        sleep 1
        counter=$((counter+1))
        #echo "counter is $counter"
        #echo "tx_total is $tx_total"
        #echo "avgtime is $avgtime"
        if [[ $counter -eq $maxcounter ]];then
                avgtime=$(((tx_total/1024)/maxcounter))
                echo "Avg time in the last $maxcounter sec:  $avgtime MB/s"
                counter=0
                rx_total=0
                tx_total=0
        fi
done
