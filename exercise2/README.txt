Exercise 2
execute the following commands on an instance of the exercise 2 AMI
$ /data/start_postgres.sh
$ git clone git@github.com:collinreinking/205_SUBMISSIONS.git
$ cd W205/exercise_2
$ createdb -h localhost -p 5432 -U postgres tcount
$ psql -d tcount -U postgres
inside of postgress run the following:
# DROP TABLE IF EXISTS Tweetwordcount;
# CREATE TABLE tweetwordcount (word TEXT PRIMARY KEY NOT NULL, count INT NOT NULL);"
# \q

$ cd extweetwordcount/
If needed:
$ pip install psycopg2
$ pip install tweepy
$ streamparse run
wait until you have collected the desired amount of data then press ctrl-c
Navigate back up a directory cd ..

Serving:
To find the number of occurrences of <word>:
$ python finalresults.py <word>

To find the number of occurrences of all words:
$ python finalresults.py

To find all words with number of occurrences between <A> and <B>:
$ run python histogram.py <A>,<B>
