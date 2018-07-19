# -*- encoding: utf-8 -*-
#
# Author:: Don Draper (<donoldfashioned@gmail.com>)
#
# Copyright (C) 2017, Don Draper
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'kitchen/driver/gogetkitchen_version'
require 'kitchen'
require 'gogetit'

module Kitchen

  module Driver

    # Gogetkitchen driver for Kitchen.
    #
    # @author Don Draper <donoldfashioned@gmail.com>
    class Gogetkitchen < Kitchen::Driver::Base
      kitchen_driver_api_version 2
      plugin_version Kitchen::Driver::GOGETKITCHEN_VERSION

      default_config :username,   'ubuntu'
      default_config :provider
      default_config :template

      Gogetit.config[:consumer] = 'kitchen'

      def create(state)
        provider = choose_provider(config[:provider])

        case provider
        when Gogetit::GogetLibvirt

          if Gogetit.maas.machine_exists?(instance.name)
            result = provider.deploy(instance.name, config)
          else
            result = provider.create(instance.name, config)
          end

        when Gogetit::GogetLXD
          result = provider.create(instance.name, config)
        end

        domain = Gogetit.maas.get_domain
        state[:hostname]      = instance.name + '.' + domain
        state[:username]      = result[:info][:default_user]
				info 'Waiting for the new domain to be available..'
        wait_until_available(instance.name)

				info 'Waiting for SSH..'
        conn = instance.transport.connection(state)
        conn.wait_until_ready
        conn.close
      end

      def destroy(state)
        provider = choose_provider(config[:provider])

        case provider
        when Gogetit::GogetLibvirt
          provider.release(instance.name)
        when Gogetit::GogetLXD
          provider.destroy(instance.name)
        end

        instance.transport.connection(state).close
      end

      def choose_provider(provider)
        case provider
        when 'lxd'
          Gogetit.lxd
        when 'kvm'
          # let's call it kvm externally but libvirt internally
          # because gogetit actually handles libvirtd
          Gogetit.libvirt
        end
      end

      def wait_until_available(hostname)
        until Gogetit.maas.domain_name_exists?(hostname)
          sleep 3
        end
      end
    end
  end
end
