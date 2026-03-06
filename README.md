# NetRat Tool

NetRat Tool is a small reconnaissance utility written in **Bash** that automates basic OSINT and network enumeration tasks for domains and IP addresses.

The tool combines **WHOIS lookups**, **DNS resolution**, and **Nmap scanning** to produce a quick overview of a target's infrastructure.

It is intended for **educational purposes**, **security research**, and **authorized penetration testing only**.

---

## Features

- WHOIS reconnaissance for IP addresses
- WHOIS reconnaissance for domain names
- Automatic DNS resolution (`dig`)
- JSON output of domains and resolved IP addresses
- Automated `nmap` scanning of discovered IPs
- Simple tabular terminal output
- Colored CLI interface

---

## What the Tool Does

### 1. WHOIS Recon

For each provided target:

**IP targets**
- Organization
- Country
- CIDR

**Domain targets**
- Organization
- Country
- Domain creation date
- Resolved IP addresses

---

### 2. DNS Enumeration

Domains are resolved using:

```
dig +short domain
```

All discovered IPs are stored in a JSON file.

Example output (`result.json`):

```json
[
  {
    "domain": "example.com",
    "ips": [
      "93.184.216.34"
    ]
  }
]
```

---

### 3. Network Scanning

Each discovered IP address is scanned using **Nmap**.

Default configuration:

```
nmap -Pn -T3 -p 1-1000 <IP>
```

This performs:

- Host discovery bypass (`-Pn`)
- Moderate scan speed (`-T3`)
- Port scan for ports **1–1000**

---

## Requirements

The following tools must be installed:

- `bash`
- `whois`
- `dig` (bind-utils / dnsutils)
- `jq`
- `nmap`

### Install dependencies (Debian / Ubuntu / Kali)

```bash
sudo apt install whois dnsutils jq nmap
```

---

## Usage

Run the script with **domains or IP addresses**:

```
./netrat.sh example.com google.com
```

or

```
./netrat.sh 8.8.8.8
```

Multiple targets are supported:

```
./netrat.sh example.com github.com 1.1.1.1
```

---

## Output

### Terminal output

Table format with:

```
Domain | IP | Organization | Country | Date/CIDR
```

### JSON output

A `result.json` file is generated:

```
result.json
```

which stores:

- domain
- resolved IP addresses

---

## Example Workflow

```
User input → WHOIS Recon → DNS Resolution → JSON Storage → Nmap Scan
```

---

## Limitations

Current limitations:

- WHOIS parsing relies on regex and may fail on some registrars
- No rate-limit handling
- Nmap scans only top 1000 ports
- No service/version detection (`-sV`)
- JSON output stores only domains and IPs

---

## Possible Improvements

Future development may include:

- service detection (`nmap -sV`)
- vulnerability scanning (`nmap --script vuln`)
- ASN lookup
- subdomain enumeration
- structured vulnerability reporting
- modular architecture instead of a single bash script

---

## Legal Disclaimer

This tool must only be used on systems **you own or have explicit permission to test**.

Unauthorized reconnaissance or scanning of networks may violate laws and regulations.

The author assumes **no responsibility for misuse** of this software.

