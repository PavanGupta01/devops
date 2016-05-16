# Build core
docker build -t u14_core -f u14_core .
docker build -t u12_core -f u12_core .
docker build -t c6_core -f c6_core .
docker build -t c7_core -f c7_core .
echo "=======>       Hurray! Done with core images        <=========="