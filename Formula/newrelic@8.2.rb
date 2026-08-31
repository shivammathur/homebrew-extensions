# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "5eebee5326bbeaa9aecd5e172492c32351831e64ad0a5bde84a1f4056cf7dd70"
    sha256 cellar: :any, arm64_sequoia: "9167b8580b5061614ea10cf7a5f199bad17cd2e8c7a4425aa0e7bce59d1666e5"
    sha256 cellar: :any, arm64_sonoma:  "c92c66dcecf4cc747cf4a9fee7a42ffed568b305d7bfaf112a8ee929105125fd"
    sha256 cellar: :any, sonoma:        "d2925c39bd5f2bfe7da7241a1664f32b361cf83767f6d58011d8a11833679d83"
    sha256 cellar: :any, arm64_linux:   "aa5ed4f89224ae19ab7ea31d33dfd3c473323ef8069c55ef52faac7082179053"
    sha256 cellar: :any, x86_64_linux:  "f5e23f84448dca8c2b692dd9a9b14d2659ba366aef97e5de79d5cb61d8b0a0c6"
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
      newrelic.daemon.address="/tmp/.newrelic82.sock"
      newrelic.daemon.port="/tmp/.newrelic82.sock"
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
