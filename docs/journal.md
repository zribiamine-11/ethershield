# Journal

## 2026-11-23 — Amine
- Installed Foundry, Slither, OpenZeppelin on Kali VM
- Problem: Foundry needs recent glibc, Ubuntu 20.04 and Red Hat failed, switched to Kali
- Connected VS Code to Kali via SSH
- Created project, wrote VulnerableVault.sol (reentrancy bug)
- Slither confirmed the reentrancy vulnerability
- Pushed everything to GitHub
- Next: write exploit test, then fix the bug

## 2026-11-26 — Amine
- Wrote 5 more vulnerable contracts: AccessControl, VulnerableTxOrigin, VulnerableSignature, mev (front-running), Dos
- Ran forge build: all compiled successfully, Foundry's built-in linter correctly flagged reentrancy-eth, tx-origin, calls-loop, missing-zero-check
- Ran Slither on src/vulnerable/: confirmed reentrancy-eth, tx-origin, calls-loop, arbitrary-send-eth findings across the contracts
- Saved audit output to docs/slither-report-vulnerable.txt
- Problem: git push hung with no prompt after GitHub token expired
- Fixed: regenerated Personal Access Token, cleared old credentials, push now works
- Next: write attacker contracts and Forge tests to exploit Access Control first, then the others