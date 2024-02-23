# oBfsC4t10n

## HackTheBox Information

- **Challenge Type:** ~~Machine~~ | **Files**
- **Challenge Rating:** 4.9
- **User Solves:** 2786
- **Difficulty Rating:** Hard

[Go to challenge](https://app.hackthebox.com/challenges/oBfsC4t10n)

## Forensics Section
*“This document came in as an email attachment. Our SOC tells us that they think there were some errors in it that caused it not to execute correctly. Can you figure out what the command and control mechanism would have been had it worked?”*

### Case Summary

On Saturday 5th of October at 10:30am, an attacker uploaded a Excel file with a malicious macro enabled, this allowed them to execute powershell code once opened the file.


### Objectives

We need to analyze and identify commands and the control mechanism the attacker wrote to understand what was compromised.


### Evidence Analyzed

**invoice-42369643.xlsm** - The macro enabled Excel file

### Findings

- The infected file : invoice-42369643.xlsm
- At the end the payload contained the flag was : HTB{g0_G3t_th3_ph1sh3R}


### Conclusion
All of this investigation was possible because we had downloaded a malicious xml file, and we’re able to see what was running inside and what was executed.

---
---


**Note:** For more detailed information, refer to the comprehensive Forensic Report in this project's directory.

Feel free to explore the files and delve into the forensic investigation process. Happy exploring!
