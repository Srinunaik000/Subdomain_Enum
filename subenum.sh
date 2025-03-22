#!/bin/bash

# Check if -u option is provided
while getopts "u:" opt; do
    case "$opt" in
        u) domain=$OPTARG ;;
        *) echo "Usage: $0 -u <domain>"; exit 1 ;;
    esac
done

# Check if domain is empty
if [[ -z "$domain" ]]; then
    echo "Usage: $0 -u <domain>"
    exit 1
fi

# Create a directory for saving results
mkdir -p subdomains

# Find subdomains using subfinder, assetfinder, and chaos
(subfinder -d "$domain"; assetfinder --subs-only "$domain"; chaos -d "$domain") | sort -u > subdomains/mixed_subdomains.txt

echo "[+] Subdomain enumeration completed. Saved to subdomains/mixed_subdomains.txt"

# Check live subdomains and capture responses
httpx -silent -sc -l subdomains/mixed_subdomains.txt | tee subdomains/all_responses.txt > /dev/null

# Ensure output files exist
touch subdomains/200-subs.txt subdomains/403-subs.txt subdomains/404-subs.txt subdomains/other-responses.txt

# Use grep and awk to filter subdomains by status code
grep "200" subdomains/all_responses.txt | awk '{print $1}' > subdomains/200-subs.txt
grep "403" subdomains/all_responses.txt | awk '{print $1}' > subdomains/403-subs.txt
grep "404" subdomains/all_responses.txt | awk '{print $1}' > subdomains/404-subs.txt

# Save other response codes
grep -Ev "200|403|404" subdomains/all_responses.txt > subdomains/other-responses.txt

echo "[+] Live subdomains categorized by status code!"
