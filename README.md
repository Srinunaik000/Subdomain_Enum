# Subdomain_Enum

# Subdomain Enumeration Script  

This script automates subdomain enumeration and categorizes live subdomains based on their HTTP response codes. It uses tools like `subfinder`, `assetfinder`, `chaos`, and `httpx` to discover and verify subdomains.  

## Features  
- Enumerates subdomains using multiple tools  
- Checks which subdomains are live  
- Categorizes live subdomains into:
  - `200-subs.txt` → Subdomains with HTTP 200 (OK)
  - `403-subs.txt` → Subdomains with HTTP 403 (Forbidden)
  - `404-subs.txt` → Subdomains with HTTP 404 (Not Found)
  - `other-responses.txt` → Other HTTP responses  

## Requirements  
Ensure you have the following installed before running the script:  
- `subfinder`  
- `assetfinder`  
- `chaos`  
- `httpx`  
- `anew` (for handling unique results)  

# You can install them using:  
```sh
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/tomnomnom/assetfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/tomnomnom/anew@latest


# Usage
Run the script with:
./sub_enum.sh -u example.com

# Example
If you want to find subdomains for example.com, run:
./sub_enum.sh -u example.com

# The script will:
Find subdomains using subfinder, assetfinder, and chaos.
Check which subdomains are live.
Save categorized subdomains in the subdomains/ directory.
Output Files
After running the script, the results will be saved in:

subdomains/mixed_subdomains.txt → All found subdomains
subdomains/all_responses.txt → All live subdomains with response codes
subdomains/200-subs.txt → Live subdomains with HTTP 200
subdomains/403-subs.txt → Live subdomains with HTTP 403
subdomains/404-subs.txt → Live subdomains with HTTP 404
subdomains/other-responses.txt → Other HTTP responses
