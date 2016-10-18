require 'spec_helper'

Config.homebrew_packages.each do |package|
  describe package(package) do
    it { should be_installed }
  end
end

if Config.gui_applications[:root].respond_to? :each
  Config.gui_applications[:root].each do |app|
    describe file("/Applications/#{app}") do
      it { should be_directory }
    end
  end
end

if Config.gui_applications[:user].respond_to? :each
  Config.gui_applications[:user].each do |app|
    describe file("#{ENV['HOME']}/Applications/#{app}") do
      it { should be_directory }
    end
  end
end

if Config.quicklook_plugins[:root].respond_to? :each
  Config.quicklook_plugins[:root].each do |plugin_name|
    describe file("/Library/QuickLook/#{plugin_name}.qlgenerator") do
      it { should be_directory }
    end
  end
end

if Config.quicklook_plugins[:user].respond_to? :each
  Config.quicklook_plugins[:user].each do |plugin_name|
    describe file("#{ENV['HOME']}/Library/QuickLook/#{plugin_name}.qlgenerator") do
      it { should be_directory }
    end
  end
end
Config.defaults.each do |k, v|
  v.each do |sk,sv|
    describe command("defaults read #{k.to_s} #{sk}") do
      its(:stdout) { should match /#{sv}/ }
    end
  end
end