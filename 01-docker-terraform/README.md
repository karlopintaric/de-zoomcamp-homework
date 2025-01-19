# Question 1:

```bash
docker run -it --entrypoint /bin/bash python:3.12.8
pip --version
```

# Question 3:

```bash
docker build -t taxi_ingest:v001 .
```

```bash
docker network create database

docker run -it \
  --network=database \
  taxi_ingest:v001 \
    --user=postgres \
    --password=postgres \
    --host=db \
    --port=5432 \
    --db=ny_taxi \
    --table_name=green_taxi_trips \
    --url=https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-10.csv.gz

docker run -it \
  --network=database \
  taxi_ingest:v001 \
    --user=postgres \
    --password=postgres \
    --host=db \
    --port=5432 \
    --db=ny_taxi \
    --table_name=zones \
    --url=https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv
```

```sql
SELECT 
    SUM(CASE WHEN trip_distance <= 1 THEN 1 ELSE 0 END) AS up_to_1_mile,
    SUM(CASE WHEN trip_distance > 1 AND trip_distance <= 3 THEN 1 ELSE 0 END) AS between_1_and_3_miles,
    SUM(CASE WHEN trip_distance > 3 AND trip_distance <= 7 THEN 1 ELSE 0 END) AS between_3_and_7_miles,
    SUM(CASE WHEN trip_distance > 7 AND trip_distance <= 10 THEN 1 ELSE 0 END) AS between_7_and_10_miles,
    SUM(CASE WHEN trip_distance > 10 THEN 1 ELSE 0 END) AS over_10_miles
FROM green_taxi_trips
WHERE lpep_dropoff_datetime >= '2019-10-01'
  AND lpep_dropoff_datetime < '2019-11-01'
;
```

# Question 4:

```sql
SELECT 
    DATE(lpep_pickup_datetime) AS pickup_day
FROM green_taxi_trips
ORDER BY trip_distance DESC
LIMIT 1;
```


# Question 5:

```sql
SELECT
	z."Zone",
	SUM(t.total_amount) AS total_for_the_day

FROM green_taxi_trips t
LEFT JOIN zones z 
	ON t."PULocationID" = z."LocationID"

WHERE 
	DATE(t.lpep_pickup_datetime) = '2019-10-18'

GROUP BY
	z."Zone"
HAVING SUM(t.total_amount) > 13000

ORDER BY 
	total_for_the_day DESC
;

```


# Question 6:

```sql
SELECT
	z_do."Zone",
	MAX(tip_amount) AS max_tip

FROM green_taxi_trips t

LEFT JOIN zones z_pu 
	ON t."PULocationID" = z_pu."LocationID"
LEFT JOIN zones z_do
	ON t."DOLocationID" = z_do."LocationID"

WHERE
	DATE_PART('month', t.lpep_pickup_datetime) = 10
	AND DATE_PART('year', t.lpep_pickup_datetime) = 2019
	AND z_pu."Zone" = 'East Harlem North'

GROUP BY
	z_do."Zone"

ORDER BY 
	max_tip DESC
;
```