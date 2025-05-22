# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

random partitioning offers simplicity and excellent load balancing by evenly distributing writes across boats without maintaining metadata. however it forces all time-range queries (like midnight 1am) to fan out every boat increasing latency and coordination overhead. as a result while ideal for write-heavy scenarios, it complicates efficient timestamp-based retrieval.

## Partitioning by Hour

partitioning by hour simplifies queries by directing time-based requests to a single boat, reducing coordination and latency. however because traffic concentrates during peak hours there is a risk of hotspots and uneven load and potentially overloading some boats while leaving others less usable. also stiff hourly boundaries lack adaptability if the observation patterns shift.

## Partitioning by Hash Value

partitioning by hash value provides excellent load balancing by evenly distributing observations regardless of time skew and enables eficient point queries by computing the hash of a specifictimestamp to target the correct boat. however range queries (like fetching all observations between midnight and 1 am) still require fanning out to every boat including higher latency and coordination overhead. also related temporal data become scattered complicating swquential or range-based analyses when compared to time-aware sharding.
