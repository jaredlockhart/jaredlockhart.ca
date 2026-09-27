#!/usr/bin/env bash
# Uploads the site to the jaredlockhart.ca bucket and clears the CloudFront cache.
set -euo pipefail

BUCKET=jaredlockhart.ca
REPO="$(cd "$(dirname "$0")/.." && pwd)"

aws s3 sync "$REPO" "s3://$BUCKET" --only-show-errors \
  --exclude ".git/*" --exclude "infra/*" --exclude "*.DS_Store" --cache-control "public, max-age=300"

DISTRIBUTION=$(aws cloudformation describe-stacks --stack-name jaredlockhart-site \
  --query "Stacks[0].Outputs[?OutputKey=='DistributionId'].OutputValue" --output text)
aws cloudfront create-invalidation --distribution-id "$DISTRIBUTION" --paths "/*" \
  --query "Invalidation.Id" --output text >/dev/null

echo "Deployed"
