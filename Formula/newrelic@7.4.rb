# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT74 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "5e1fee63bddab856888e49c992a07ca340cc1f1eba554189a83524207091e25f"
    sha256 cellar: :any, arm64_sequoia: "eee6fcc0c8be5ee4a143820bd96a4a16edac4804693b34fc6e2e748ca41833dd"
    sha256 cellar: :any, arm64_sonoma:  "e0317c7e988a4dedfce70d2f0a679e38de13852497c7d86284b8823c54bfe5a5"
    sha256 cellar: :any, sonoma:        "69a14be802d8f04bf7208bd65f712069c6db95352b05547fb3f96824d2ce3312"
    sha256 cellar: :any, arm64_linux:   "61e48a8c583439c5c21f380fdbe744edb90b4d1e84d1b3567563f7c768bc7880"
    sha256 cellar: :any, x86_64_linux:  "b7bcb8776a0f2ffd65bae397765f6aaffef826fdeb4c078597490d9cbb298882"
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
