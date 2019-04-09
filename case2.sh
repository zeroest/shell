#! /bin/sh
echo "is linux fun? (yes/no)"
read answer
case $answer in
	yes | y | Y | Yes | YES)
		echo "it is so nice!!!"
		echo "linux is so Fun!";;
	[nN]*)
		echo "No!!!";;
	*)
		echo "you should yes or no."
		exit 1;;
esac
exit 0
