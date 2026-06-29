# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "43bca5a905caf8b852e1c7a7a11687a5e31bc0a2f0088f1e07db080657bb0713"
    sha256 cellar: :any, arm64_sequoia: "03627499a3d7ef12a9479747143091eafa6341604f66bed5ad6863d732da6b80"
    sha256 cellar: :any, arm64_sonoma:  "556fada2c4b443d30a93750eff2861bf1c49b0eb5f4571eff615216cbea1a155"
    sha256 cellar: :any, sonoma:        "53641ef57c346f2e056a29ed2aa367af8d98efb7d2cc4107517885aee719a378"
    sha256 cellar: :any, arm64_linux:   "cb99084436dc59fb14c813271875041ff00273e3fab574b56048c5bdef17859f"
    sha256 cellar: :any, x86_64_linux:  "4e1f18123d229609d5d7829de2ecd2365588ae02e68846db2d6ef09df41304a6"
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
