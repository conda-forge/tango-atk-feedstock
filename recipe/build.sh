# Update the version in pom files (remove SNAPSHOT)
mvn versions:set versions:update-child-modules -DnewVersion="${PKG_VERSION}" -DprocessAllModule -DgenerateBackupPoms=false -Prelease
# Skip the tests because they require to have a tango database running
mvn install -DskipTests

# Generate third party license report
mvn license:aggregate-third-party-report
cp target/reports/aggregate-third-party-report.html .

mkdir -p ${PREFIX}/share/java

install -m 0644 widget/target/ATKWidget-${PKG_VERSION}.jar ${PREFIX}/share/java
install -m 0644 core/target/ATKCore-${PKG_VERSION}.jar ${PREFIX}/share/java
ln -s ATKWidget-${PKG_VERSION}.jar ${PREFIX}/share/java/ATKWidget.jar
ln -s ATKCore-${PKG_VERSION}.jar ${PREFIX}/share/java/ATKCore.jar
