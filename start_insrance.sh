#$1= <file>.pem
#$2= ip.region
#$3= user
#$4= directory to copy
scp -r -i $1 $4 $2.compute.amazonaws.com:~/
ssh -i $1 $3@$2.compute.amazonaws.com

