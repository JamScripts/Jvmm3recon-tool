#!/bin/bash 

# Title 

echo "========== JVMM3Recon Tool ==========" 

# Get domain from user input 
read -p "Enter the domain to scan: " domain

# Timestamp for log file 
timestamp=$(date +%Y%m%d-%H%M%S) 
logfile="recon-$domain-$timestamp.txt" 

# WHOIS lookup 
echo -e "\n[+] WHOIS Info for $domain" | tee -a $logfile
whois $domain | tee -a $logfile

# DNS info 
echo -e "\n[+] DNS Records" | tee -a $logfile 
dig $domain any +noall +answer | tee -a $logfile 

# Subdomain enumeration 
echo -e "\n[+] Subdomains Found:" | tee -a $logfile
sublist3r -d $domain | tee -a $logfile

#Nmap Scan
echo -e "\n[+] Nmap Scan (Top 1000 Ports)" | tee -a $logfile 
nmap -sV -Pn -T4 $domain | tee -a $logfile 

#finished 
echo -e "\n[✓] Recon Complete. Results saved to $logfile"
