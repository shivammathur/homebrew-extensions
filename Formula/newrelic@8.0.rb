# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "6c76fe703b7d35a1eba5adc75dad59b36e09076f99068854b95e2a40a16ef195"
    sha256 cellar: :any, arm64_sequoia: "e3c9d7cfbf769f42234c5c798fa57f278fcacf926a231f8896854105585c1200"
    sha256 cellar: :any, arm64_sonoma:  "eaa1c50d8138d6c8e3d1031c12a17595043caf9002ffba999fbec618836beac0"
    sha256 cellar: :any, sonoma:        "ef7f42210038179fb5806b1e75848973bd332d2bc5be47f00b19117863abd753"
    sha256 cellar: :any, arm64_linux:   "d368b376c6e659a6cf01e6692ed624551989e5f37081363ab2b1163d666b801f"
    sha256 cellar: :any, x86_64_linux:  "5670fd21e444e1fbd14176bcf55ec6ade1c3df3a08f6a390e23d8a20b39d9adc"
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
