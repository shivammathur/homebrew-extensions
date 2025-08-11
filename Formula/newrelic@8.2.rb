# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT82 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.0.0.25.tar.gz"
  sha256 "43310e8999ee11ff97e8573eb5d1e6f9ffbc8caf9c76960cdc732f413353276f"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "137ce52fb5462c6b49086786aa04ad24f059119ff882cc083eaf8ec2afb10a39"
    sha256 cellar: :any,                 arm64_sonoma:  "43f2f03d5ea2dba2b5b605603c4f092d02b1222dbdc0ad099d6546c50ba5964c"
    sha256 cellar: :any,                 arm64_ventura: "a2cb8077832ef372c512bc093e0839e91ed397f5fc3c01cf9e4455128f7f8222"
    sha256 cellar: :any,                 ventura:       "cf933e71a5c989ecd375d8ce327d03ed5cecdc391d5ffcfb3fb2c929a13601bf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "12aa8d44397198161b222026e1dd1598092052b65d407a1cf208db60e6468b04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5fa8122d98c5b4311e038ceab529c95b68848e6efa519de95cb68ea8686c5747"
  end

  # for pcre_compile
  depends_on "pcre"

  # for the agent
  depends_on "protobuf-c"

  # for aclocal + glibtoolize
  depends_on "automake" => :build
  depends_on "libtool" => :build

  # for the daemon
  depends_on "go" => :build

  def config_file_content
    <<~EOS
      [#{extension}]
      #{extension_type}="#{module_path}"
      newrelic.daemon.location="#{prefix}/daemon"
      newrelic.daemon.address="/tmp/.newrelic82.sock"
      newrelic.daemon.port="/tmp/.newrelic82.sock"
      newrelic.logfile="/var/log/newrelic_php_agent.log"
      newrelic.daemon.logfile="/var/log/newrelic_daemon.log"
    EOS
  rescue error
    raise error
  end

  def install
    inreplace "agent/config.m4", "-l:libprotobuf-c.a", "-lprotobuf-c"
    inreplace "axiom/Makefile", "AXIOM_CFLAGS += -Wimplicit-fallthrough", "#AXIOM_CFLAGS += -Wimplicit-fallthrough"
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
