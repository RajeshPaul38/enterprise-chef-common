require "spec_helper"

if (os[:family] == "redhat" && os[:release].to_i == 5) ||
   os[:family] == "debian"
  describe command("ps x | grep 'runsvdir.*\/opt\/tp' | grep -v grep") do
    its(:exit_status) { should eq(1) }
  end

  describe file("/etc/inittab") do
    its(:content) { should_not match(/\/opt\/tp\/embedded\/bin\/runsvdir-start/) }
  end
end
