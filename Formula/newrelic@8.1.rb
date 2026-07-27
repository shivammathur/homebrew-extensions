# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT81 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.9.0.38.tar.gz"
  sha256 "f3a90afd9a9fbb380d953f3a6fff7a4ce14231f8077c61f0794d17027d2f2d69"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "49bb1113aa795faf3e821c847b860f6824d872b3d1bc8a5e18f7a5401dc47755"
    sha256 cellar: :any, arm64_sequoia: "53142057cb4c0d8c6b4440f09e1ac737d7f6a1d9f92c4b506add5dfe1805e948"
    sha256 cellar: :any, arm64_sonoma:  "6de5f1c06541b4b845175316f372fe359146f7a6253c65dd5f781a3b81e246de"
    sha256 cellar: :any, sonoma:        "f512721f2d269aad4e88d43b3102237dcf3e95c3e76558124a3dd6d22e8fa987"
    sha256 cellar: :any, arm64_linux:   "f942549a24042957578efd95dbb56dfe98e80245ed1d17b45885287edaae0214"
    sha256 cellar: :any, x86_64_linux:  "6458e185c6897b61b7c020728315e14e237598dc2a7e773d9709be9e0eb09474"
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
      newrelic.daemon.address="/tmp/.newrelic81.sock"
      newrelic.daemon.port="/tmp/.newrelic81.sock"
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
