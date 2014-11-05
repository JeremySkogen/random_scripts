#!/bin/bash                                                                                                         

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# Check for backed up files
if [ ! -f /etc/hosts_lc_ext ]; then
  echo "First Run, creating backup..."
  cp /etc/hosts /etc/hosts_backup
  echo "Backup saved as /etc/hosts_backup"

  echo "Creating a new lighcrest hosts file...."
  cp /etc/hosts /etc/hosts_lc_ext

  cat >> /etc/hosts_lc_ext <<EOL

# Version 1.0
# Overrides for testing
8.26.65.171 www.stocktwits.com
8.26.65.171 stocktwits.com
8.26.65.171 stocktwits.net



8.26.65.171 assets0.new.stocktwits.net
8.26.65.171 assets0.stocktwits.net
8.26.65.171 assets0.new.stocktwits.com
8.26.65.171 assets0.stocktwits.com
8.26.65.171 assets1.new.stocktwits.net
8.26.65.171 assets1.stocktwits.net
8.26.65.171 assets1.new.stocktwits.com
8.26.65.171 assets1.stocktwits.com

8.26.65.171 assets2.new.stocktwits.net
8.26.65.171 assets2.stocktwits.net
8.26.65.171 assets2.new.stocktwits.com
8.26.65.171 assets2.stocktwits.com

8.26.65.171 assets3.new.stocktwits.net
8.26.65.171 assets3.stocktwits.net
8.26.65.171 assets3.new.stocktwits.com
8.26.65.171 assets3.stocktwits.com

8.26.65.171 new.stocktwits.net
8.26.65.171 store.stocktwits.net
8.26.65.171 new.stocktwits.com
8.26.65.171 store.stocktwits.com


8.26.65.173 api.stocktwits.com

8.26.65.174 es.stocktwits.com

8.26.65.175 quotes.stocktwits.com
8.26.65.175 quote1.stocktwits.com

8.26.65.172 admin.stocktwits.com
8.26.65.172 resque.stocktwits.com

8.26.65.176 sa.stocktwits.com
8.26.65.176 spaceape.stocktwits.com
8.26.65.176 dashboard.stocktwits.com
EOL
  echo "Hosts backup/creation finished"
fi

case "$1" in
  start)
    # Oracle listener and instance startup
    echo -n "Entering Testing mode...  "
    cp /etc/hosts_lc_ext /etc/hosts
    echo "Begin testing"
    ;;
  stop)
    # Oracle listener and instance startup
    echo -n "Exiting Testing mode...  "
    cp /etc/hosts_backup /etc/hosts
    echo "Hosts restored to original"
    ;;
  remove)
    # Oracle listener and instance startup
    echo -n "Removing residual files...  "
    cp /etc/hosts_backup /etc/hosts
    rm /etc/hosts_backup
    rm /etc/hosts_lc_ext
    echo "Hosts restored to original"
    ;;
  *)
    echo "Usage: $0 start|stop|remove"
    exit 1
esac

