# Obscure

## HackTheBox Information

- **Challenge Type:** ~~Machine~~ | **Files**
- **Challenge Rating:** 4.9
- **User Solves:** 5439
- **Difficulty Rating:** Not too easy

[Go to challenge](https://app.hackthebox.com/challenges/84)

## Forensics Section

### Case Summary

On Saturday 1st of October at 10:30am, an attacker found a vulnerability in our web server that allows arbitrary PHP file upload in our Apache server. Suchlike, the hacker has uploaded what seems to be like an obfuscated reversed shell (support.php). We monitor our network 24/7 and generate logs from tcpdump (we provided the log file for the period of two minutes before we terminated the HTTP service for investigation).

### Objectives

We need to analyze and identify commands the attacker wrote to understand what was compromised.

### Evidence Analyzed

**19-05-21_22532255.pcap** - Packet capture file of the 2 last minutes of the network.

**Support.php** - The malicious file which is supposedly an obfuscated shell.

### Findings

- The kdbx file contains the master password.
- The encoded messages within the pcap file containing the return of linux commands.
- The flag was stored inside : HTB{pr0tect_y0_shellZ}

### Conclusion
Never open a file from an unknown source. If you receive an email with an attachment, do not open it unless you know the sender and are expecting the file. If you are not sure, contact the sender to verify the file.

In general, try to always use a password manager that can generate strong random 16 characters passwords containing letters, digits and special symbols.

By using common passwords or auto generated ones by Microsoft, hackers can easily brute force them.



---
---


**Note:** For more detailed information, refer to the comprehensive Forensic Report in this project's directory.

Feel free to explore the files and delve into the forensic investigation process. Happy exploring!
