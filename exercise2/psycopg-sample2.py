import sys

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

if len(sys.argv) != 2:
    print "wprd argument missing"
    exit(1)

word = sys.argv[1]

print "word is", word

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

cur = conn.cursor()

cur.execute("UPDATE tweetwordcount SET count=count+1 WHERE word=%s", (Word,))

print "number of updated rows", cur.rowcount

if cur.rowcount == 0;
    cur.execute("INSERT INTO tweewordcount (word,count) VALUES (%S, 1)", (word,))

conn.commit()

#Select
cur.execute("SELECT word, count from tweetwordcount")
records = cur.fetchall()
for rec in records:
   print "word = ", rec[0]
   print "count = ", rec[1], "\n"
conn.commit()

conn.close()
