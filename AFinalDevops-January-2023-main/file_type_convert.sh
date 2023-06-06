#!/$bin/$bash
path="$1"
if [[ -d "$1" ]]; then
	cd $1
	for i in $(find "$(pwd)" -type f -iname "*.txt"); do
		file_full=$($basename "$i")
		dirn=$(dirname "$i")
		extension="${file_full##*.}"
		filename="${file_full%.*}"
		mv "$i" "${dirn}/${filename}.log" 
		
	done
else 
	echo "Entered path is not a directory"
fi	

