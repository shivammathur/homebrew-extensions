# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.8.0.37.tar.gz"
  sha256 "0fe3a49170310cda15099d79b9ed6424cc653656f8c8df9309b56edcd3798e31"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "1fb2174ac64c089094a25c45ddae168e8f50ff1db0272ea43f3d46ae75cd8714"
    sha256 cellar: :any, arm64_sequoia: "8d49c933d6b1a3b76d98090878b9e2a024fb375ca57bd3f7619151d83ecae22a"
    sha256 cellar: :any, arm64_sonoma:  "ddcea5e5a013bd160702a9489cb6fd0e7ca28105ef83e02359b7ae8a393e3afa"
    sha256 cellar: :any, sonoma:        "e81ef34103cff4381c7a7d73a8b1d7cb7b2f2a11b8c7fa10628c48926def0ec7"
    sha256 cellar: :any, arm64_linux:   "dc827d9972900afccd1fac76d85dc7c277b423fa229155c42284f4e4d6f67a23"
    sha256 cellar: :any, x86_64_linux:  "c67fcd0ad27b11fb7db0754a75ca5c4457363a06aedceecce022b861856a76a6"
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
      newrelic.daemon.address="/tmp/.newrelic84.sock"
      newrelic.daemon.port="/tmp/.newrelic84.sock"
      newrelic.logfile="/var/log/newrelic_php_agent.log"
      newrelic.daemon.logfile="/var/log/newrelic_daemon.log"
    EOS
  rescue error
    raise error
  end

  def install
    inreplace "agent/config.m4", "-l:libprotobuf-c.a", "-lprotobuf-c"
    inreplace "axiom/Makefile", "AXIOM_CFLAGS += -Wimplicit-fallthrough", "#AXIOM_CFLAGS += -Wimplicit-fallthrough"
    inreplace "daemon/go.mod", /toolchain go.*/, "toolchain go#{Formula["go"].version}"
    inreplace "agent/php_txn_private.h",
              "nr_php_txn_get_supported_security_policy_settings();",
              "nr_php_txn_get_supported_security_policy_settings(nrtxnopt_t* opts);"
    system "make", "-C", "axiom", "v1.pb-c.c"
    system "make", "all"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
