{% set base_dir = grains['lldev']['install_dir'] + "/pki" %}
{% set user     = grains['user']['username'] %}

#
# .lldev/pki is where all x509 generation will happen
#
pki_dir:
  file.directory:
    - name: {{base_dir}}
    - user: {{user}}

issued_certs_dir:
  file.directory:
    - name: {{base_dir}}/issued_certs
    - user: {{user}}

#
# Generate Certificate Authority 
#
test.lessonly.ca.key:
  x509.private_key_managed:
    - name: {{base_dir}}/ca.key
    - runas: {{user}}
    - bits: 4096
    - require:
      - file: pki_dir

test.lessonly.ca.crt:
  x509.certificate_managed:
    - name: {{base_dir}}/ca.crt
    - signing_private_key: {{base_dir}}/ca.key
    - CN: ca.lessonly.test
    - C: US
    - ST: Indiana
    - L: Indianapolis
    - basicConstraints: "critical CA:true"
    - keyUsage: "critical cRLSign, keyCertSign"
    - subjectKeyIdentifier: hash
    - authorityKeyIdentifier: keyid,issuer:always
    - days_valid: 365
    - days_remaining: 0
    - backup: True
    - runas: {{user}}
    - require:
      - x509: test.lessonly.ca.key
      - file: {{base_dir}}
      - file: pki_dir

# Generate wildcard cert signed by CA
test.lessonly.wildcard.crt:
  x509.certificate_managed:
    - name: {{base_dir}}/issued_certs/wildcard.lessonly.test.crt
    - public_key: {{base_dir}}/issued_certs/wildcard.lessonly.test.key
    - CN: "*.lessonly.test"
    - C: US
    - ST: Indiana
    - L: Indianapolis
    - O: Lessonly
    - OU: Lessonly Development
    - days_remaining: 90
    - subjectAltName: "DNS:lessonly.test, DNS:*.lessonly.test"
    - signing_private_key: {{base_dir}}/ca.key
    - signing_cert: {{base_dir}}/ca.crt
    - backup: True
    - runas: {{user}}
    - managed_private_key:
        name: {{base_dir}}/issued_certs/wildcard.lessonly.test.key
        bits: 4096
        backup: True
    - require:
      - x509: test.lessonly.ca.key
      - x509: test.lessonly.ca.crt
      - file: {{base_dir}}
      - file: pki_dir

{% if grains['os_family'] == 'MacOS' %}
#
# install into the user's login keychain
# (Privieged access)
install_ca_cert:
    cmd.run:
        - name: security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain {{base_dir}}/ca.crt
        - onchanges:
            - x509: test.lessonly.ca.crt
        - require:
            - x509: test.lessonly.ca.crt
{% endif %}
{% if grains['os_family'] == 'Debian' %}

/usr/local/share/ca-certificates/lldev:
  file.directory:
    - mode: 755


/usr/local/share/ca-certificates/lldev-ca.crt:
  file.managed:
    - mode: 644
    - source:  {{base_dir}}/ca.crt
    - require:
      - file: /usr/local/share/ca-certificates/lldev
      - x509: test.lessonly.ca.crt


libnss3-tools:
  pkg.installed

install_ca_cert:
    cmd.run:
        - name: update-ca-certificates
        - onchanges:
            - x509: test.lessonly.ca.crt
            - file: /usr/local/share/ca-certificates/lldev-ca.crt
        - require:
            - x509: test.lessonly.ca.crt
            - file: /usr/local/share/ca-certificates/lldev-ca.crt

install_ca_cert_ff:
    cmd.run:
        - name: certutil -d sql:$HOME/.pki/nssdb -A -t "C,C,C" -n lldev-ca -i /usr/local/share/ca-certificates/lldev-ca.crt
        - onchanges:
            - x509: test.lessonly.ca.crt
            - file: /usr/local/share/ca-certificates/lldev-ca.crt
        - require:
            - x509: test.lessonly.ca.crt
            - file: /usr/local/share/ca-certificates/lldev-ca.crt

{% endif %}