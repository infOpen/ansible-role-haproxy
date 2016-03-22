require 'serverspec'

if ENV['TRAVIS']
    set :backend, :exec
end

describe 'haproxy Ansible role' do

    # Declare variables
    group_name = ''
    main_config_file = ''
    packages = Array[]
    service_name = ''
    user_name = ''

    if ['debian', 'ubuntu'].include?(os[:family])
        group_name = 'haproxy'
        main_config_file = '/etc/haproxy/haproxy.cfg'
        packages = Array[ 'haproxy' ]
        service_name = 'haproxy'
        user_name = 'haproxy'
    end

    it 'install role packages' do
        packages.each do |pkg_name|
            expect(package(pkg_name)).to be_installed
        end
    end

    describe user(user_name) do
        it { should exist }
        it { should belong_to_group group_name }
    end

    describe file(main_config_file) do
        it { should exist }
        it { should be_file }
    end

    describe service(service_name) do
        it { should be_running }
        it { should be_enabled }
    end
end

