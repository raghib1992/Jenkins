# install key tool
sudo apt install openjdk-14-jre-headless -y
# generate key
keytool -genkey -keyalg RSA -alias selfsigned -keystore jenkins_keystore.jks -storepass mypassword -keysize 2048 