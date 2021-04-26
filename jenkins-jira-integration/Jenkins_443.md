# install key tool
sudo apt install openjdk-14-jre-headless -y
# generate key
keytool -genkey -keyalg RSA -alias selfsigned -keystore jenkins_keystore.jks -storepass mypassword -keysize 2048 

read -s -p "Keystore Password:" password
echo
sudo cp jenkins_keystore.jks /var/lib/docker/volumes/jenkins_home/_data
docker run -d -v jenkins_home:/var/jenkins_home -v $(which docker):/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -p 443:8443 -p 50000:50000 jenkins/jenkins:lts --httpPort=-1 --httpsPort=8443 --httpsKeyStore=/var/jenkins_home/jenkins_keystore.jks --httpsKeyStorePassword=$password

*******************************************************************************************************************************************
this script prompts the user for the keystore password
-v jenkins_home:/var/jenkins_home creates a named volume called jenkins_home, which happens to exist at /var/lib/docker/volumes/jenkins_home/_data by convention.
if the directory at /var/lib/docker/volumes/jenkins_home/_data does not exist yet, you will need to create the named volume using docker volume before copying the keystore.
-p 443:8443 maps 8443 jenkins port in the container to the 443 port of the host
--httpPort=-1 --httpsPort=8443 blocks http and exposes https on port 8443 inside the container (port 443 outside the container).
--httpsKeyStore=/var/jenkins_home/jenkins_keystore.jks --httpsKeyStorePassword=$password provides your keystore, which exists at /var/jenkins_home/jenkins_keystore.jks inside the container ( /var/lib/docker/volumes/jenkins_home/_data/jenkins_keystore.jks outside the container).
-v /var/run/docker.sock:/var/run/docker.sock is optional, but is the recommended way to allow your jenkins instance to spin up other docker containers.
WARNING: By giving the container access to /var/run/docker.sock, it is easy to break out of the containment provided by the container, and gain access to the host machine. This is obviously a potential security risk.
-v $(which docker):/usr/bin/docker is also optional, but allows your jenkins container to be able to run the docker binary.
Be aware that, because docker is now dynamically linked, it no longer comes with dependencies, so you may be required to install dependencies in the container.
The alternative is to omit -v $(which docker):/usr/bin/docker and install docker within the jenkins container. You'll need to ensure that the inner container docker and the outer host docker are the same version, so that communication over /var/run/docker.sock is supported.
In either case, you may want to use a Dockerfile to create a new Jenkins docker image.
Another alternative is to include -v $(which docker):/usr/bin/docker, but install a statically-linked binary of docker on the host machine.
You should now be able to access the jenkins webportal via https with no port specifier (since port 443 is default for https)