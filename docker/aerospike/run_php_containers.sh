# run.sh will launch PHP docker containers in one go


# Ubuntu 12 
docker run -itdp 1253:22 u12_php5329
docker run -itdp 1254:22 u12_php5445
docker run -itdp 1255:22 u12_php5530
docker run -itdp 1256:22 u12_php5617

# Ubuntu 14
docker run -itdp 1453:22 u14_php5329
docker run -itdp 1454:22 u14_php5445
docker run -itdp 1455:22 u14_php5530
docker run -itdp 1456:22 u14_php5617

# ============================      CENTOS Containers    =============================

# Centos 6 
docker run -itdp 6532:22 c6_php5329
docker run -itdp 6544:22 c6_php5445
docker run -itdp 6553:22 c6_php5530
docker run -itdp 6561:22 c6_php5617

# Centos 7
docker run -itdp 7532:22 c7_php5329
docker run -itdp 7544:22 c7_php5445
docker run -itdp 7553:22 c7_php5530
docker run -itdp 7561:22 c7_php5617

