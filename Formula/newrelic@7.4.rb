# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT74 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.7.0.36.tar.gz"
  sha256 "459357439b19cc19ec6a0120487810e968a270855ee0e68b111ed4ac45d6fc75"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "27326a50439b44386d81167726d743ef416d4bcba558d6ebd19e56339cf91cce"
    sha256 cellar: :any,                 arm64_sequoia: "d175ee7da4b6efc1844c6d21360b630643572dbc1793c4e0817f168f7913aa21"
    sha256 cellar: :any,                 arm64_sonoma:  "0996fb3c2090abbc37bacc3425475f52e1bc6ef12119cfbc657dd05282412640"
    sha256 cellar: :any,                 sonoma:        "99047dc743e5f1b948843975da2021d63c6d3d8508a9e26b521a4a5508bb4f40"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4e7f5b204a47a9c2748cd759b724764702e418beb303fed7a478c5f5b6e7cfe1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "57c7b72a233123b73a2955667a4d7711f130a411a33b2724e1b2eb9945fddf98"
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
      newrelic.daemon.address="/tmp/.newrelic80.sock"
      newrelic.daemon.port="/tmp/.newrelic80.sock"
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
