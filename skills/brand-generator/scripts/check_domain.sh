#!/usr/bin/env bash
# Check domain availability via whois for one or more domains.
# Usage: check_domain.sh domain1.com domain2.ai domain3.co
# Exit codes: always 0. Output is human-readable status per domain.

set -euo pipefail

if [ $# -eq 0 ]; then
  echo "Usage: check_domain.sh <domain1> [domain2] [domain3] ..."
  exit 1
fi

for domain in "$@"; do
  echo "=== $domain ==="
  whois_output=$(whois "$domain" 2>&1 || true)

  # Check for common "not found" indicators across registrars
  if echo "$whois_output" | grep -qiE \
    "no match|not found|no data found|no entries found|domain not found|status: free|status: available|DOMAIN NOT FOUND|No Object Found"; then
    echo "AVAILABLE"
  elif echo "$whois_output" | grep -qiE \
    "domain name:|registrar:|creation date:|name server:|registrant|updated date:"; then
    echo "TAKEN"
    # Show registrar and dates for context
    echo "$whois_output" | grep -iE "registrar:|creation date:|expir|updated date:" | head -6
  else
    echo "UNCERTAIN — manual check recommended"
    echo "$whois_output" | head -10
  fi
  echo ""
done
