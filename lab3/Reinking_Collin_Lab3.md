##### List the execution time of the weblog aggregation query for Hive, SparkSQL, and SparkSQL on Parquet.

Hive: 52.464 seconds
SparkSQL: 10.375 seconds
SparkSQL on 2.973 seconds

##### How many jobs does Hive launch? Does SparkSQL launch jobs?
Hive launches 2 jobs.
SparkSQL does not launch jobs.

##### Write a query which joins weblogs_parquet to user_info and counts the top 5 locations. List the locations.
```
SELECT
    user_info.location,
    count(user_info.location) as loc_count
FROM weblogs_parquet
JOIN user_info ON (weblogs_parquet.user_id=user_info.user_id)
GROUP BY location
ORDER BY loc_count desc
LIMIT 5;
```
gives these as the to 5 location

| Location | Count |
|:--------:|:-----:|
| La Fayette | 9 |
| Leeds | 47 |
| Blountsville | 46 |
| Hayden | 45 |
| Hamilton | 45 |
