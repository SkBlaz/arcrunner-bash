## Ddistribution
## inputs: a folder of .xrsl jobs, cluster_id, timeout of refresh, proxy
## outputs a folder_meta with job descriptions, a folder folder_outputs with outputs
## 1.) first submit
## 2.) while loop that: a) goes to folder_outputs, arcget -i ../folder_meta/jids.txt

XRSL_FOLDER=$1;CLUSTER=$2;TIMEOUT=$3;PROXY=$4; mkdir $XRSL_FOLDER"_META"; XRSL_META=$XRSL_FOLDER"_META/current.txt"; touch $XRSL_META; XRSL_RESULTS=$XRSL_FOLDER"_RESULTS"; mkdir $XRSL_RESULTS; cd $XRSL_FOLDER; arcsub -c $CLUSTER -o "../"$XRSL_META *.xrsl; cd ../$XRSL_RESULTS; while sleep $TIMEOUT; do arcproxy -S $PROXY; PVAR=$(arcstat -i "../"$XRSL_META|grep 'no jobs' | wc -l); echo "Prepared to finish: $PVAR"; if [ $PVAR -gt 0 ]; then echo "Breaking with $PVAR" && break; fi; arcget -i "../"$XRSL_META; done
