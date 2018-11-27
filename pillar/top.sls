base:
    '*':
      - defaults
    'os_family:Debian':
      - match: grain
      - Debian
    'os_family:MacOS':
      - match: grain
      - MacOS


