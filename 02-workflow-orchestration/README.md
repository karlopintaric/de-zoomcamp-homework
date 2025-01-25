# Question 3:

```sql
SELECT COUNT(*)
FROM ny_taxi.public.yellow_tripdata
WHERE
	filename LIKE 'yellow_tripdata_2020%';

```

# Question 4:

```sql
SELECT COUNT(*)
FROM ny_taxi.public.green_tripdata
WHERE
	filename LIKE 'green_tripdata_2020%';

```

# Question 5:

```sql
SELECT COUNT(*)
FROM ny_taxi.public.yellow_tripdata
WHERE
	filename = 'yellow_tripdata_2021-03.csv';

```