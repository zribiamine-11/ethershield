# EtherShield

Ethereum smart contract security lab: develop, exploit (in a controlled environment), audit and fix vulnerable Solidity contracts.

> **Educational project.** All attacks run on a local Anvil network with fake accounts and fake ETH. No real funds or private keys are used.

## Objectives

- Build deliberately vulnerable contracts (vault, token, governance, multisig)
- Reproduce each vulnerability with automated Forge tests
- Audit the code with Slither and separate false positives from confirmed flaws
- Fix the flaws and prove the fix with regression, fuzz and invariant tests

## Vulnerabilities studied

| Vulnerability | Status | Fix |
|---|---|---|
| Reentrancy | In progress | Checks-Effects-Interactions, ReentrancyGuard |
| Access control | Planned | OpenZeppelin roles |
| tx.origin authentication | Planned | msg.sender |
| Signature replay | Planned | Nonce, expiration, EIP-712 |
| Front-running / MEV | Planned | Commit-reveal |
| Denial of Service | Planned | Pull-over-push |

## Tech stack

| Tool | Purpose |
|---|---|
| Foundry (Forge, Anvil) | Compile, test, local blockchain |
| Solidity 0.8.x | Smart contracts |
| Slither | Static analysis |
| OpenZeppelin | Secure contract library |
| Git / GitHub | Version control and collaboration |

## Project structure

```
src/            smart contracts (vulnerable and fixed versions)
test/           exploit tests and non-regression tests
script/         local deployment scripts
lib/            dependencies (forge-std, OpenZeppelin) — installed automatically
docs/           journal, notes, screenshots
foundry.toml    Foundry configuration
```

---

## Setup guide (for each team member)

Each person installs the tools **once** on their own machine/VM, then clones the project.

### Step 1 — Install the required tools (system-wide, run once)

```bash
sudo apt update
sudo apt install -y git curl python3-pip pipx build-essential

# Foundry (Forge + Anvil)
curl -L https://foundry.paradigm.xyz | bash
export PATH="$PATH:$HOME/.foundry/bin"
echo 'export PATH="$PATH:$HOME/.foundry/bin"' >> ~/.bashrc
foundryup

forge --version
anvil --version

# Slither
pipx ensurepath
pipx install slither-analyzer
pipx install solc-select
solc-select install 0.8.20
solc-select use 0.8.20
slither --version
```

### Step 2 — Get the project (do NOT run `forge init`)

```bash
git clone --recurse-submodules https://github.com/zribiamine-11/ethershield.git
cd ethershield
forge build
```

This downloads the actual project, including the contracts, tests, and the `lib/` dependencies (OpenZeppelin, forge-std) already configured.

### Step 3 — Create your own branch

```bash
git checkout -b your-name
```

### Step 4 — Verify everything works

```bash
anvil
```
Leave this running in one terminal. In another terminal:
```bash
forge build
forge test
slither .
```

---

## Optional: Connect VS Code to your Kali VM (remote editing)

### On your Windows PC

Test the SSH connection first:
```
ssh YOUR_USER@YOUR_KALI_IP
```

Create/edit `C:\Users\YOUR_PC_USER\.ssh\config`:
```
Host kali-ethershield
    HostName YOUR_KALI_IP
    User YOUR_KALI_USER
```

### Connect with VS Code

1. Install VS Code.
2. Install the **Remote - SSH** extension (Microsoft).
3. Press `F1` → **Remote-SSH: Connect to Host...** → choose `kali-ethershield`.
4. Choose **Linux** if asked, enter your password, and wait for the first-time setup.
5. Open the terminal with `` Ctrl+` ``.
6. Open the project folder: `File → Open Folder` → path to `ethershield`.

---

## Daily workflow

```bash
git add .
git commit -m "describe what you changed"
git push
```

Open a Pull Request on GitHub to merge your branch into `main` once your work is reviewed.

---

## Safety and scope

Experiments are limited to contracts and nodes owned by the team. Testing third-party contracts or public networks without explicit authorization is forbidden. No real private keys or assets are ever used.

## Team

- [Name 1]
- Zribi Amine
- [Name 3]
- [Name 4]

Supervisor: [Name]

## License

MIT