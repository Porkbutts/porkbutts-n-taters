# Security Policy

<!--
  TEMPLATE: Customize this security policy for your project.
  Having a clear security policy helps both human and AI contributors
  understand how to handle security issues responsibly.
-->

> **Template Notice**: This is a placeholder. Customize this policy for your project.

## Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability, please report it responsibly.

### How to Report

**DO NOT** open a public GitHub issue for security vulnerabilities.

Instead, please report security issues via:

<!-- Choose and customize one of these options: -->

**Option 1: GitHub Security Advisories (Recommended)**
- Go to the Security tab of this repository
- Click "Report a vulnerability"
- Fill out the form with details

**Option 2: Email**
- Send details to: security@your-domain.com
- Use our PGP key (if applicable): [link to key]

### What to Include

Please include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

### Response Timeline

<!-- Customize these timelines for your team's capacity -->

| Action | Timeline |
|--------|----------|
| Initial response | 48 hours |
| Status update | 7 days |
| Resolution target | 90 days |

We will keep you informed of our progress and may ask for additional information.

## Supported Versions

<!-- Update this table for your project's version support -->

| Version | Supported |
|---------|-----------|
| x.x.x   | Yes       |
| < x.x   | No        |

## Security Best Practices

### For Contributors

When contributing to this project:

1. **Never commit secrets** - No API keys, passwords, or credentials in code
2. **Validate input** - Sanitize all user input
3. **Use parameterized queries** - Prevent SQL injection
4. **Escape output** - Prevent XSS attacks
5. **Keep dependencies updated** - Monitor for security advisories
6. **Follow least privilege** - Request minimal permissions

### For AI Agents

AI agents working on this codebase should:

1. **Never generate or suggest hardcoded credentials**
2. **Flag potential security issues** when encountered
3. **Follow OWASP guidelines** for web applications
4. **Suggest security improvements** when relevant
5. **Not disable security features** without explicit approval

## Security Features

<!-- Document security features of your project -->

This project implements:

- [ ] Authentication (describe method)
- [ ] Authorization (describe model)
- [ ] Input validation
- [ ] Output encoding
- [ ] HTTPS enforcement
- [ ] Security headers
- [ ] Rate limiting
- [ ] Audit logging

## Acknowledgments

We appreciate responsible disclosure and will acknowledge security researchers who help us improve our security (with permission).

<!-- Optional: link to a security hall of fame or acknowledgments page -->
