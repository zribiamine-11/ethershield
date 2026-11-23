# Journal

## 2026-11-23 — Amine
- Installed Foundry, Slither, OpenZeppelin on Kali VM
- Problem: Foundry needs recent glibc, Ubuntu 20.04 and Red Hat failed, switched to Kali
- Connected VS Code to Kali via SSH
- Created project, wrote VulnerableVault.sol (reentrancy bug)
- Slither confirmed the reentrancy vulnerability
- Pushed everything to GitHub
- Next: write exploit test, then fix the bug