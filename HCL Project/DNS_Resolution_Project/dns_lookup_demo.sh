#!/usr/bin/env bash
# DNS Resolution Comparison — safe command helper
# Run in Kali Linux. This script does NOT modify /etc/hosts.
set -u
DOMAIN="example.com"
MISSING="nonexistent.invalid"
TEST_DNS="192.0.2.1"

echo "=== DNS RESOLUTION COMPARISON ==="
echo
echo "[1] Configured DNS resolver"
cat /etc/resolv.conf
echo
echo "[2] Successful lookup with nslookup"
nslookup "$DOMAIN"
echo
echo "[3] Successful lookup with dig"
dig "$DOMAIN"
echo
echo "[4] Compact DNS answer"
dig +short "$DOMAIN"
echo
echo "[5] Non-existent reserved test name (expected NXDOMAIN)"
nslookup "$MISSING"
dig "$MISSING"
echo
echo "[6] Unreachable documentation-only test address (expected timeout)"
nslookup "$DOMAIN" "$TEST_DNS"
dig @"$TEST_DNS" "$DOMAIN" +time=2 +tries=1
echo
echo "[7] System resolver view (may consult /etc/hosts before DNS)"
getent hosts "$DOMAIN"
echo
echo "For the optional /etc/hosts demonstration, follow the manual steps in"
echo "the report and remove the exact test line immediately after the test."
echo "This script intentionally makes no changes to system configuration."
