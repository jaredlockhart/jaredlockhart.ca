# jaredlockhart.ca
Personal Website

Served from the `jaredlockhart.ca` S3 bucket (static-website hosting) through CloudFront for HTTPS
(stack `jaredlockhart-site`; certificate in stack `jaredlockhart-cert`; DNS at name.com).

```
infra/deploy.sh   # upload the site to the bucket and clear the CloudFront cache
```
