# see https://github.com/jamesbeltonIBM/Mount-an-IBM-COS-bucket-to-Linux-using-s3fs for more information
# about what's going on in this file.

#cloud-config
runcmd:
 - add-apt-repository main
 - apt-get install s3fs
 - echo <<HMAC secret>> > /root/.passwd-s3fs
 - chmod 600 /root/.passwd-s3fs
 - mkdir /mycosbucket
 - s3fs rules-public /mycosbucket -o passwd_file=/root/.passwd-s3fs -o url=https://s3.eu-gb.cloud-object-storage.appdomain.cloud
 - sleep 10
 - touch /mycosbucket/$HOSTNAME
