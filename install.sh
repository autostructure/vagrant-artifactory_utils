#!/bin/bash

yum localinstall http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
puppet module install autostructure-artifactory_ha
