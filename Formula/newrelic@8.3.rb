# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "f609e64dcc93e9d0775e85083de6c82c3f7fbfd5b53b755bfb8cd92e571dbbe3"
    sha256 cellar: :any,                 arm64_sequoia: "c2bba138a66cf8c43c2cf93d3ad2ad661d1ec481a127bc9216158a7fbb186332"
    sha256 cellar: :any,                 arm64_sonoma:  "a4ef17f86a816b197ee98fbad220df1b791fa6ba8cece69117ce9124a02e4ea9"
    sha256 cellar: :any,                 sonoma:        "233b8bd105dd111ef99b81b5e05a8e564065f3289909e6cd5a0e1dacd82a6afc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b504d29f0fea0909a9e6e3c3b08fd615de0110a9b88252ae85ce8006e06af6a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "42996973f52cfcaf5036648f3ec1fa9259e249a8ecaac68a40736ad44d020a5b"
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
