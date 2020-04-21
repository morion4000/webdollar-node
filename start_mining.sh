#wget https://webdftp.vpnromania.ro/ftp/blockchainDB3.tar.gz
wget http://webd-blockchain.ddns.net:9001/blockchainDB3.tar.gz
mkdir blockchainDB3
tar -C blockchainDB3 -zxvf blockchainDB3.tar.gz
unlink blockchainDB3.tar.gz

npm run build_terminal_menu
npm run build_terminal_worker

COMMAND="node --max_old_space_size=10240 dist_bundle/terminal-menu-bundle.js"

if [ "$WALLET" = "" ]
then
  (sleep 30;echo 8;) | $COMMAND || true
else
  echo $WALLET > wallet.json
  (sleep 30;echo 4;sleep 5;echo 'wallet.json';sleep 5;echo 7;sleep 5;echo 1;sleep 5;pkill -2 node) | $COMMAND || true
  (sleep 30;echo 8;) | $COMMAND || true
fi
