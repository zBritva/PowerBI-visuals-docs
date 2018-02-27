# Create certificate (Windows)

----------

Run the following command to generates the certificate by using powershell New-SelfSignedCertificate cmdlet on Windows 8 or higer.

For **Windows** **7** tool requires OpenSSL installation. Util `openssll` must be avialable from command line.

For install OpenSSL visit [https://www.openssl.org](https://www.openssl.org) or [https://wiki.openssl.org/index.php/Binaries](https://wiki.openssl.org/index.php/Binaries)

```
pbiviz --install-cert
```

# Create certificate (MacOS)

Usually OpenSSL utils available in Linux or MacOS operations systems.

Otherwise you can install from

*Brew* package manager
```
brew install openssl
brew link openssl --force
```

or by using *MacPorts*
```
sudo port install openssl
```

After installation OpenSSL for generating new certificate call:

```
pbiviz --install-cert
```

# Create certificate (Linux)

OpenSSL utils aren't available in your Linux operation system, you can install by using following commands.

For *APT* package manager:

```
sudo apt-get install openssl
```

For *Yellowdog Updater, Modified*:

```
yum install openssl
```

For *Redhat Package Manager*:

```
rpm install openssl
```

If OpenSSl aliready avialable in your operation system call

```
pbiviz --install-cert
```
to generate new certificate.

Or get from [https://www.openssl.org](https://www.openssl.org) or [https://wiki.openssl.org/index.php/Binaries](https://wiki.openssl.org/index.php/Binaries)

## Move to next step:

[Install generated SSL certifications to enable live preview of visuals](tools/CertificateSetup.md)