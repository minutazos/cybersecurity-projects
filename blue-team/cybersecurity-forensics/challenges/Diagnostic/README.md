# Diagnostic

## HackTheBox Information

- **Challenge Type:** **Machine** | ~~Files~~
- **Challenge Rating:** 5.0
- **User Solves:** 3039
- **Difficulty Rating:** Easy

[Go to challenge](https://app.hackthebox.com/challenges/360)

## Forensics Section

### Case Summary

On Saturday 1st of October at around 12:30pm, our SOC identified numerous phishing emails coming in claiming to have a document about an upcoming round of layoffs in the company. The emails all contain a link to diagnostic.htb/layoffs.doc. The DNS for that domain has since stopped resolving, but the server is still hosting the malicious document (your docker).


### Objectives

The objective is to analyze the phishing email’s malicious file and discover what it could have done to a computer.


### Evidence Analyzed

The **layoffs.doc** file, which is apparently a simple Microsoft Word doc file.

### Findings

- The 223_index_style_fancy.html web page
- The payload contained inside the web page: HTB{msDt_4s_A_pr0toc0l_h4nDl3r…sE3Ms_b4D}


### Conclusion
Never open a file from an unknown source. If you receive an email with an attachment, do not open it unless you know the sender and are expecting the file. If you are not sure, contact the sender to verify the file.

Consider using Unix or Macos on critical or administrators computers as they tend to be less targeted by malware.


---
---


**Note:** For more detailed information, refer to the comprehensive Forensic Report in this project's directory.

Feel free to explore the files and delve into the forensic investigation process. Happy exploring!
