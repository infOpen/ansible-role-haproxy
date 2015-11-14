haproxy
=======

[![Build Status](https://travis-ci.org/infOpen/ansible-role-haproxy.svg?branch=master)](https://travis-ci.org/infOpen/ansible-role-haproxy)

Install haproxy package.

Requirements
------------

This role requires Ansible 1.5 or higher, and platform requirements are listed
in the metadata file.

Role Variables
--------------

Default role variables

    # Version to install
    haproxy_version_number : "1.5"
    haproxy_version_type   : "stable"

    # Path prefix
    haproxy_path_prefix_etc : "/etc/haproxy"

    # Data variables
    haproxy_frontends : []
    haproxy_backends  : []
    haproxy_listens   : []
    haproxy_userlists : []

    haproxy_global_process_mgmt :
      ca_base  : "/etc/ssl/certs"
      crt_base : "/etc/ssl/private"
      chroot   : "/var/lib/haproxy"
      daemon   : True
      user     : haproxy
      group    : haproxy
      nbproc   : 1
      cpu_map  : []
      pidfile  : "/var/run/haproxy.pid"
      ulimit_n : False
      node     : "{{ ansible_hostname }}"
      description : ''
      stats :
        socket  : "/run/haproxy/admin.sock"
        timeout : 30s
        maxconn : 10
        bind_process : "all"
      log :
        - address : "/dev/log"
          facility : "local0"
          #max_level : notice
          #min_level : notice
        - address : "/dev/log"
          facility : "local1"
          max_level : notice
      log_send_hostname : "{{ ansible_hostname }}"
      log_tag : "haproxy"
      ssl_server_verify : required
      ssl_default_bind_ciphers :
        - "kEECDH+aRSA+AES"
        - "kRSA+AES"
        - "+AES256"
        - "RC4-SHA"
        - "!kEDH"
        - "!LOW"
        - "!EXP"
        - "!MD5"
        - "!aNULL"
        - "!eNULL"
      ssl_default_bind_options   : []
      ssl_default_server_ciphers : []
      ssl_default_server_options : []

    haproxy_global_performance : {}

    haproxy_global_debugging :
      debug : False
      quiet : False

    haproxy_defaults :
      mode : http
      log  :
        - address  : /dev/log
          facility : local1
          level    : notice
      timeout :
        - param : 'connect'
          value : '5000ms'
        - param : 'client'
          value : '50000ms'
        - param : 'server'
          value : '50000ms'
      options :
        - httpclose
        - forwardfor except 127.0.0.0/8
        - redispatch
        - abortonclose
        - httplog
        - dontlognull
      errorfile :
        - code : 400
          file : /etc/haproxy/errors/400.http
        - code : 403
          file : /etc/haproxy/errors/403.http
        - code : 408
          file : /etc/haproxy/errors/408.http
        - code : 500
          file : /etc/haproxy/errors/500.http
        - code : 502
          file : /etc/haproxy/errors/502.http
        - code : 504
          file : /etc/haproxy/errors/504.http
      persist_rdp_cookie      : True
      persist_rdp_cookie_name : 'msts'

Debian family specific default vars

    # HAProxy packages for Debian
    haproxy_packages :
      - haproxy

    haproxy_service_name : haproxy


Dependencies
------------

None

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: achaussier.haproxy }

License
-------

MIT

Author Information
------------------

Alexandre Chaussier (for Infopen company)
- http://www.infopen.pro
- a.chaussier [at] infopen.pro
