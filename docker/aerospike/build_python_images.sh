# Build Target Images

# Python Ubuntu 12
docker build -t u12_py269 -f u12_py269 .
docker build -t u12_py273 -f u12_py273 .
docker build -t u12_py34 -f u12_py34 .
docker build -t u12_py35 -f u12_py35 .

# Python Ubuntu 14
docker build -t u14_py269 -f u14_py269 .
docker build -t u14_py276 -f u14_py276 .
docker build -t u14_py34 -f u14_py34 .
docker build -t u14_py35 -f u14_py35 .

echo "=========>       Hurray! Done with Ubuntu images        <============="

# Python Centos 6
docker build -t c6_py266 -f c6_py266 .
docker build -t c6_py276 -f c6_py276 .
docker build -t c6_py34 -f c6_py34 .
docker build -t c6_py35 -f c6_py35 .

# Python Centos 7
docker build -t c7_py269 -f c7_py269 .
docker build -t c7_py275 -f c7_py275 .
docker build -t c7_py34 -f c7_py34 .
docker build -t c7_py35 -f c7_py35 .
