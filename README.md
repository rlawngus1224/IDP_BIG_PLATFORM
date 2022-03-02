# IDP_BIG_PLATFORM
Konkuk Univ. IDP LAB big data platform project

## 2022_03_02 Report
현재 하둡 설치 및 core-site.xml hdfs-site.xml mapred-site.xml 파일 설정이 완료

포트 설정에 대한 이해도가 부족함

해당 이미지 pull 받은 뒤

<namenode 컨테이너>

  docker run -itd --privileged -h namenode.hadoop --name namenode.hadoop -p 8000:50070 rlawngus1224/base_img:1.0 init

<secondnode 컨테이너>

  docker run -itd --privileged -h secondnode.hadoop --name secondnode.hadoop --link namenode.hadoop:namenode.hadoop rlawngus1224/base_img init

<datanode1 컨테이너>
  
  docker run -itd --privileged -h datanode1.hadoop --name datanode1.hadoop --link namenode.hadoop:namenode.hadoop rlawngus1224/base_img:1.0 init

<datanode2 컨테이너>

  docker run -itd --privileged -h datanode2.hadoop --name datanode2.hadoop --link namenode.hadoop:namenode.hadoop rlawngus1224/base_img:1.0 init

명령으로 생성 후 

  docker exec -it namenode.hadoop bin/bash

명령으로 namenode에 접근

각 컨테이너의 ip를 vi /etc/hosts 명령어를 통해 기재

  vi /$HADOOP_CONFIG/slaves 명령어로 datanode1 , datanode2 기재

이후 각 컨테이너에 ssh 접근 후 /etc/hosts 파일 수정

namenode에서 start-all.sh 명령어로 하둡 실행 가능
