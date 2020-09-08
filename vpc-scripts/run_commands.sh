#cloud-config
runcmd:
 - add-apt-repository main
 - apt-get install s3fs
 - echo 75225bcb880148eea9cf5b4dcf9ae5a3:7c3ce36ae0c4631440051f79ecf98b7da2eda348586726d6 > /root/.passwd-s3fs
 - chmod 600 /root/.passwd-s3fs
 - mkdir /mycosbucket
 - s3fs rules-public /mycosbucket -o passwd_file=/root/.passwd-s3fs -o url=https://s3.eu-gb.cloud-object-storage.appdomain.cloud
 - sleep 10
 - touch /mycosbucket/$HOSTNAME
