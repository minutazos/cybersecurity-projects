# MBCoin

## HackTheBox Information

- **Challenge Type:** ~~Machine~~ | **Files**
- **Challenge Rating:** 4.9
- **User Solves:** 210
- **Difficulty Rating:** Medium

[Go to challenge](https://app.hackthebox.com/challenges/370)

## Forensics Section

### Case Summary

We have been actively monitoring the most extensive spear-phishing campaign in recent history for the last two months. This campaign abuses the current crypto market crash to target disappointed crypto owners. A company's SOC team detected and provided us with a malicious email and some network traffic assessed to be associated with a user opening the document. Analyze the supplied files and figure out what happened.


### Objectives

This report is a summary of how the attacker managed to access the recruiter’s crypto account by using a spear-phishing campaign. 


### Evidence Analyzed

**mbcoin.doc** - The phishing document with VBA code

**mbcoin.pcapng** -The network traffic at the moment of the incident.


### Findings

- The infected file : mbcoin.doc
- The network traffic file: mbcoin.pcapng
- The flag obtained: HTB{wH4tS_4_sQuirReLw4fFl3?}



### Conclusion
All of this investigation was possible because we had a network trace recorded in the pcapng file and gave us the exported objects, and the mbcoin.doc allowed us to retrieve the powershell code to deobfuscate those html files to .dll files and later we used Ghidra to analyze those .dll files and obtained the ldr() function containing the flag.

---
---


**Note:** For more detailed information, refer to the comprehensive Forensic Report in this project's directory.

Feel free to explore the files and delve into the forensic investigation process. Happy exploring!
