# Install And Auth

Use this reference when the user needs first-time Fabric CLI setup on Windows or macOS in user-auth mode.

## What This Skill Covers

- install or upgrade `ms-fabric-cli` with `pip`
- add the user-level script directory to persistent PATH
- verify `fab --version`
- check `fab auth status`
- launch `fab auth login` for interactive user sign-in

## Preferred Flow

Run:

```powershell
python scripts/bootstrap_fab.py --login
```

That flow:
1. installs or upgrades Fabric CLI for the current user
2. updates user PATH automatically
3. verifies the `fab` executable
4. launches interactive user auth if needed

## PATH Behavior

- Windows: updates the current user's PATH in `HKCU\Environment`
- macOS: appends PATH exports to shell startup files for the current shell family

The current shell session may still need to be restarted before plain `fab` resolves on PATH everywhere.

## Verification

If the user wants a non-mutating check, run:

```powershell
python scripts/bootstrap_fab.py --verify-only
```

## PATH Repair Only

If `fab` is already installed but not recognized reliably, run:

```powershell
python scripts/repair_fab_path.py
```

To inspect the change without writing anything:

```powershell
python scripts/repair_fab_path.py --dry-run
```

## Notes

- This skill is intentionally optimized for user auth, not service principal automation.
- Browser interaction is still required during `fab auth login`.
- Installing with `--user` avoids requiring admin rights in the common case.
