# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.10.0.39.tar.gz"
  sha256 "9c778d5f6f13c58e67efb469e02e8a3131719d9065bf03334b971a623799020a"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "a66ba0069270e43a833b65793746a2c770952f8884f116bb6283f8e31ad6f258"
    sha256 cellar: :any, arm64_sequoia: "4222f6c9011697ce97176aeeb8857caeffe937a6615f6ccbe5caeaa174870638"
    sha256 cellar: :any, arm64_sonoma:  "9cb9d3a5ed5b3fa07aa03f4c418feb8dc719eca0e2d32f7c722431e955adde61"
    sha256 cellar: :any, sonoma:        "f4e967e65233336372a46bb7e825bed4e3f4155d422f0c0bb5fa95542ef63c6f"
    sha256 cellar: :any, arm64_linux:   "55278d446d7ab78117d78a04e2971e17fdfc7d06dce6f4deb897131f4a910d7f"
    sha256 cellar: :any, x86_64_linux:  "a0b7893df34a0a687fd5a4bc04fccd80a5ffc49e639999c3c79f7c2bfbe6f984"
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
