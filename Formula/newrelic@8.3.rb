# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT83 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.13.0.43.tar.gz"
  sha256 "d81b1fc4da458e18343df9f2a03f19d5725f60c0fb6dc37a8c1a9afab1233151"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "408258023bcf47938d1672014163f44bdb431cc9b2f2434b0234bac677910969"
    sha256 cellar: :any, arm64_tahoe:       "34a7d4ba5fe8085e08f1a23e6ba5f92bdf153c670e2b2dea3663db7b6c1e775b"
    sha256 cellar: :any, arm64_sequoia:     "2127532069b35cc2050b3fff0b361e966e21c3f5ee2ac68c10eb47688126c990"
    sha256 cellar: :any, arm64_linux:       "ae182a690cc3d9ca29f4f0bb362bc3147f63d6c83c58a5135347f6f6b457d94a"
    sha256 cellar: :any, x86_64_linux:      "87de155be80893258eb2b14f25bb25dc491805ab56a282a926bbf325ef23c8a3"
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
      newrelic.daemon.address="/tmp/.newrelic83.sock"
      newrelic.daemon.port="/tmp/.newrelic83.sock"
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
    inreplace "agent/php_txn.h",
              "nr_php_txn_get_supported_security_policy_settings();",
              "nr_php_txn_get_supported_security_policy_settings(nrtxnopt_t* opts);"
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
