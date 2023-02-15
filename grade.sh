CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -f ListExamples.java ]]
then
    echo "ListExamples exists"
else 
    echo "Yikes no file, that's an error pal"
    exit 1
fi

cp ../TestListExamples.java ./
cp -r ../lib ./

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" ListExamples.java 2>error-output.txt
if [[ $? == 0 ]]
then
    echo "Congrats it compiled"
else
    echo "Gosh buddy it's not compiling"
    cat error-output.txt
    exit $?
fi

java -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" org.junit.runner.JUnitCore TestListExamples >error-output.txt 2>&1
cat error-output.txt
