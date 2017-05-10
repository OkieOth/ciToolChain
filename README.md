# Continous integration tool chain based on docker

## Tests
1. Check if nexes works
```bash
curl -u admin:admin123 http://nexus.test.eiko/service/metrics/ping

# insecure version - unknown CA
curl --insecure -u admin:admin123 https://nexus.test.eiko/service/metrics/ping
```
