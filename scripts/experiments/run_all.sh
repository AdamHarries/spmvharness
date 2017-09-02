#/bin/bash

datasetf=$1
echo "Dataset folder: $datasetf"

spmv=$2
echo "SparseMatrixDenseVector excutable: $spmv"

kernelfolder=$3
echo "KernelFolder: $kernelfolder"

runfile=$4
echo "runfile: $runfile"

platform=$5
echo "Platform: $platform"

device=$6
echo "Device: $device"

host=$(hostname)

# Get some unique data for the experiment ID
now=$(date +"%Y-%m-%dT%H-%M-%S%z")
hsh=$(git rev-parse HEAD)
exID="$hsh-$now"

start=$(date +%s)

mkdir -p .gold_results
mkdir -p .gold
mkdir -p "results/results-$exID"

kernelcount=$(ls $kernelfolder | wc -l)
matrixcount=$(ls $datasetf | wc -l)
taskcount=$((kernelcount*matrixcount)) 
echo "taskcount: $taskcount"

i=0
for m in $(cat $datasetf/datasets.txt);
do
	rdir="results/results-$exID/$m/"
	mkdir -p $rdir

	for k in $(ls $kernelfolder);
	do
		echo "Processing matrix: $m - $i/$taskcount" 
		kname=$(basename $k .json)
		echo "Using kernel: $kname"

		runstart=$(date +%s)
		$spmv -p $platform \
			  -d $device \
			  -i 5 \
			  -m $datasetf/$m/$m.mtx \
			  -f $m \
			  -k $kernelfolder/$k \
			  -r $runfile \
			  -n $host \
			  -t 20 \
			  -e $exID &>$rdir/result_$kname.txt
			  # -p $platform \
			 # 2>results-$exID/result_$m_$kname.txt
		runend=$(date +%s)
		runtime=$((runend-runstart))

		scripttime=$((runend-start))

		echo "Run took $runtime seconds, total time of $scripttime seconds"
		i=$(($i + 1))
	done
done

echo "finished experiments"