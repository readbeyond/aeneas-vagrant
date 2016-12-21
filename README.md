# aeneas-vagrant

**aeneas-vagrant** automates the creation of a Vagrant box to run **aeneas**

* Version: 1.7.1
* Date: 2016-12-21
* Developed by: [Alberto Pettarin](http://www.albertopettarin.it/)
* License: the GNU Affero General Public License Version 3 (AGPL v3)
* Contact: [aeneas@readbeyond.it](mailto:aeneas@readbeyond.it)

## Goal

**aeneas** is a Python/C library and a set of tools to automagically synchronize audio and text (aka forced alignment).
See the [aeneas documentation](http://www.readbeyond.it/aeneas/) for further details.

This repo contains the files needed to automate
the creation of a [Vagrant box](https://www.vagrantup.com/)
to run **aeneas** inside [VirtualBox](https://www.virtualbox.org/).


## System Requirements, Supported Platforms and Installation

### System Requirements

1. 2 GB RAM, 2 GHz CPU (4 GB RAM, 3 GHz CPU recommended)
2. [VirtualBox](http://www.virtualbox.org/)
3. [Vagrant](http://www.vagrantup.com/)

### Supported Platforms

Any host platform supported by VirtualBox and Vagrant.

This Vagrant box has been tested under Linux (Debian) and Mac OS X,
but it should work on Windows too.

### Installation

Make sure you have VirtualBox and Vagrant installed on your machine,
and 3.5 GB of free space.

```bash
git clone https://github.com/readbeyond/aeneas-vagrant.git
cd aeneas-vagrant
```

The default configuration (file `Vagrantfile`)
creates a VirtualBox machine with 2 GB of RAM:

```
vb.memory = "2048"
```

You might want to set a larger value if you have more RAM
on your host machine, for example `4096` if you have more than 4 GB of RAM.

To start the initialization of the Vagrant box, just run:

```bash
vagrant up
```

Vagrant will download a base box and
then it will run the `setup.sh` provisioning script
to install all the executables, Python modules,
and source code needed to run **aeneas**.

This one-time process might take between 5 and 30 minutes,
depending on the bandwidth of your network connection
and processor clock, and it will download roughly 1 GB of data,
creating a VirtualBox image of roughly 3.5 GB on your host machine disk.


## Usage

### Starting the box

1. Start the box:

    ```bash
    vagrant up
    ```

2. Log into the box:

    ```bash
    vagrant ssh
    ```

3. You will get a new prompt:

    ```bash
    vagrant@debian-jessie:~$
    ```


### Running `aeneas`

At this point you can run **aeneas** as if it was installed
on your host machine. For example:

```bash
vagrant@debian-jessie:~$ python -m aeneas.tools.execute_job -h
```

will show the usage message for `execute_job`.

You can also use the `aeneas_execute_job` shortcut:

```bash
vagrant@debian-jessie:~$ aeneas_execute_job -h
```

If you want to run the sample job:

```bash
vagrant@debian-jessie:~$ aeneas_execute_job ../../usr/local/lib/python2.7/dist-packages/aeneas/tools/res/job.zip /vagrant/
```

will execute the sample job and place its output
in the `/vagrant/` shared directory.

The `/vagrant/` directory is shared between
the host machine (usually your PC) and the guest machine (the virtual box);
you can use it to read your input materials and
to write the files output by **aeneas**.
For example, you can read `job.zip` from your host machine
and write its output to your host machine:

```bash
vagrant@debian-jessie:~$ aeneas_execute_job /vagrant/job.zip /vagrant/
```

Similarily, you can use the following shortcuts:

* `aeneas_check_setup`
* `aeneas_convert_syncmap`
* `aeneas_download`
* `aeneas_execute_job`
* `aeneas_execute_task`
* `aeneas_plot_waveform`
* `aeneas_synthesize_text`
* `aeneas_validate`

Run any of them with the `-h` or `--help` flag
to print its usage message.


### Suspending, closing and destroying the box

To suspend the box:

```bash
vagrant@debian-jessie:~$ exit
vagrant suspend
```

To shut the box down:

```bash
vagrant@debian-jessie:~$ exit
vagrant halt
```

You can resume from suspended or halted state by:

```bash
vagrant up
```

If you want to destroy the box,
deleting the VirtualBox machine files:

```bash
vagrant destroy
```

(The `destroy` command cannot be undone!
You will need to recreate the box from scratch
to work with aeneas another time.
Use it only if you are sure you want to delete
the virtual box.)

### Updating `aeneas`

If you want to update `aeneas`
inside the Vagrant box
(e.g., because a new version has been released):

1. Start the box:

    ```bash
    vagrant up
    ```

2. Log into the box:

    ```bash
    vagrant ssh
    ```
3. Update `aeneas` via `pip`:

    ```bash
    sudo pip install aeneas --upgrade
    ```

## License

**aeneas-vagrant** is released under the terms of the
GNU Affero General Public License Version 3.
See the [LICENSE](LICENSE) file for details.

## Acknowledgments

[Daniel Bair](https://github.com/danielbair) helped improving the setup script.



