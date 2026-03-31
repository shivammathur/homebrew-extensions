# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT74 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.6.0.34.tar.gz"
  sha256 "45143e55f99a615163ba9281e7c7b8e8b27589d891dfa9ee77ccaba2a3f97583"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d0e4b2a5378935d4a4add2f8335ab423144390948bb8b46df35ed48120783b1d"
    sha256 cellar: :any,                 arm64_sequoia: "9806269007297b78d132ca5587f948a5dc7482bec3ecd4fecc65b985142ad1c2"
    sha256 cellar: :any,                 arm64_sonoma:  "04ef0b6beff318b558f55d82a34e3d30263ca968eeaf62086e5485ba24f4dad5"
    sha256 cellar: :any,                 sonoma:        "a10abc118b587b5c62b89be1f466e8a6e125387a86b44fcdd250067d5875290e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a6425e5ca3519387c4d15cd48dc8af8c4a56eacabd68cf4db3d0b760ab92f28b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "85e2941f940c5b72461213f4bc80f14fbb6c138a6e0e9c9ccfb46f180fac2eb7"
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
