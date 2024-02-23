# Reminiscent

## HackTheBox Information

- **Challenge Type:** ~~Machine~~ | **Files**
- **Challenge Rating:** 4.9
- **User Solves:** 11423
- **Difficulty Rating:** Not too easy

[Go to challenge](https://app.hackthebox.com/challenges/39)

## Forensics Section

### Case Summary

On Saturday 1st of October at 11am, suspicious traffic was detected from a recruiter's virtual PC. A memory dump of the offending VM was captured before it was removed from the network for imaging and analysis. Our recruiter mentioned he received an email from someone regarding their resume. A copy of the email was recovered and is provided for reference. Find and decode the source of the malware to find the flag.

### Objectives

This report is a summary of how the attacker managed to access the recruiter’s PC by using a phishing email.

### Evidence Analyzed

**Resume.eml** - The phishing email received by the recruiter.

**Imageinfo.txt** - The information about the recruiter os and system.

**flounder-pc-memdump.elf** - The memory dump of the recruiter pc just before it was retired from the network.


### Findings

- The infected file : resume.pdf.lnk that contained the malicious payload.
- At the end the payload contained the flag was : HTB{$_j0G_y0uR_M3m0rY_$}


### Conclusion
All of this investigation was possible because we had a memory dump of this system just after the attack. 

If you don't have a memory dump, you can still use some tools to find the process that is running the attack.

But it's much harder to find it, that's why you should never power off your system after an attack. 

Instead, you should just disconnect the network cable.

Moreover, you should never download a file from an untrusted email address.
If you do, you should scan it with an antivirus before opening it.




---
---


**Note:** For more detailed information, refer to the comprehensive Forensic Report in this project's directory.

Feel free to explore the files and delve into the forensic investigation process. Happy exploring!
