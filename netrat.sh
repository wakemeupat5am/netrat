#!/bin/bash 
#Neccessary hacker wannabe script kiddy decorators
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
BOLD="\033[1m"
RESET="\033[0m"

echo -e "${BOLD}${BLUE}==================== NetRat Tool ====================${RESET}"
echo -e "${YELLOW}[!] Warning${RESET} Reconing without hosts permission is a crime"

if [[ $1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
  printf "%-16s | %-16s | %-30s | %-8s | %-10s\n" "Domain" "IP" "ORG" "Country" "CIDR"
  printf "%-16s-+-%-16s-+-%-30s-+-%-8s-+-%-10s\n" "----------------" "----------------" "------------------------------" "--------" "----------"
  for arg in "$@"; do 
    org=$(whois "$arg" | grep -iPo '(Organization:   |ORG:  \s+)\K.*' | head -n 1)
    cedr=$(whois "$arg" | grep -iPo '(CIDR:           |CID:  \s+)\K.*'  | head -n 1)
    country=$(whois "$arg" | grep -iPo '(Country:        |CNT:\s+)\K.*'  | head -n 1)
    printf "%-16s | %-16s | %-30s | %-8s | %-10s\n"  " " "$arg" "$org" "$country" "$cedr"
  done
  fi
echo "doing domain"
if [ -n $1 ]; then
  printf "%-16s | %-16s | %-30s | %-8s | %-10s \n" "Domain" "IP" "ORG" "Country" "RegDate"
  printf "%-16s-+-%-16s-+-%-30s-+-%-8s-+-%-10s\n" "----------------" "----------------" "------------------------------" "--------" "----------"
    for arg in "$@"; do
      org=$(whois "$arg" | grep -iPo '(Registrant Organization: |organization: |Organization Name......: |org:           \s+)\K.*'  | head -n 1)
      sleep 1
      country=$(whois "$arg" | grep -iPo '(Registrant Country: |Country................: |country:         \s+)\K.*'  | head -n 1)
      sleep 1
      regdate=$(whois "$arg" | grep -iPo '(Domain created: |Creation Date: |created:    \s+)\K.*'  | head -n 1)
      sleep 1
      ipdig=$(dig +short "$arg" | head -n 1)
      printf "%-16s | %-16s | %-30s | %-8s | %-10s\n" "$arg" "$ipdig" "$org" "$country" "$regdate"
      dig +short "$arg" | tail -n +2 | while read -r ip; do
        printf "%-16s | %-16s | %-30s | %-8s | %-10s\n" " " "$ip" " " " " " "
      done

    done
fi



