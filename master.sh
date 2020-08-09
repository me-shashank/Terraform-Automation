#! /bin/bash
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >> '/etc/yum.repos.d/mongodb-org-4.2.repo'

sudo su
yum install -y mongodb-org

service mongod start

sed -i 's/bindIp: 127.0.0.1/#bindIp: 127.0.0.1/g' /etc/mongod.conf
sed -i 's/#replication:/replication:\n  replSetName: "Replica-1"/g' /etc/mongod.conf

service mongod restart

echo "ip1 mongo1\n1p2 mongo2\nip3 mongo3" >> /etc/hosts

mongo << EOF

rs.initiate({
     _id : "Replica-1",
     members: [
       { _id : 0, host : "mongo1:27017" },
       { _id : 1, host : "mongo2:27017" },
       { _id : 2, host : "mogno3:27017" }
     ]
   }
)
rs.add("mongo1")
rs.add("mongo2")
rs.add("mongo3")

EOF
