# <a name="title"></a> Gogetkitchen

A test kitchen driver for [Gogetit](https://github.com/itisnotdone/gogetit).
Due to the [collision](https://github.com/test-kitchen/test-kitchen/blob/master/lib/kitchen/driver.rb#L38-L44) of namespace with Kitchen::Driver, it is named as Gogetkitchen not Gogetit.

## <a name="requirements"></a> Requirements

https://github.com/itisnotdone/gogetit

## <a name="installation"></a> Installation and Setup

Please read the [Driver usage][driver_usage] page for more details.

```bash

$ export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

$ gem install kitchen-gogetkitchen

```
## <a name="config"></a> Configuration
For lxd provider
```yaml

---
driver:
  name: gogetkitchen

provisioner:
  name: chef_zero

transport:
  ssh_key: <%= Dir.home + '/.ssh/id_rsa' %>

platforms:
  - name: lxc01
    driver:
      provider: lxd
      alias: default
      maas-on-lxc: true

suites:
  - name: default
    run_list:
      - recipe[all_nodes::default]
    attributes:

```

For kvm(libvirt) provider
```yaml

---
driver:
  name: gogetkitchen

provisioner:
  name: chef_zero

transport:
  ssh_key: <%= Dir.home + '/.ssh/id_rsa' %>

platforms:
  - name: kvm01
    driver:
      provider: kvm
      distro: bionic

suites:
  - name: default
    run_list:
      - recipe[all_nodes::default]
    attributes:

```
## Provider specific behaviors
### For KVM(Libvirt)
- It will always use `deploy`/`release` pair once `create`d.
### For LXD
- It is able to convey `options` which Gogetit LXD provider comsumes.


## <a name="Uninstall"></a> Uninstall

Please read the [Driver usage][driver_usage] page for more details.

```bash

gem uninstall kitchen-gogetkitchen gogetit maas-client

```

## <a name="development"></a> Development

* Source hosted at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make. For
example:

1. Fork the repo
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## <a name="authors"></a> Authors

Created and maintained by [Don Draper][author] (<donoldfashioned@gmail.com>)

## <a name="license"></a> License

Apache 2.0 (see [LICENSE][license])


[author]:           https://github.com/enter-github-user
[issues]:           https://github.com/enter-github-user/kitchen-gogetkitchen/issues
[license]:          https://github.com/enter-github-user/kitchen-gogetkitchen/blob/master/LICENSE
[repo]:             https://github.com/enter-github-user/kitchen-gogetkitchen
[driver_usage]:     http://docs.kitchen-ci.org/drivers/usage
[chef_omnibus_dl]:  http://www.chef.io/chef/install/
