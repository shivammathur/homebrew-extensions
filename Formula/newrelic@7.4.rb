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
    sha256 cellar: :any,                 arm64_tahoe:   "e494e471f4d0be2d6c84730fe024888967e6063a11eaada4b969d1a5162355d3"
    sha256 cellar: :any,                 arm64_sequoia: "efb02e3950484ecf907aea2ebdcbddfeb10c83fc9177f019c265afcc26f9cfb7"
    sha256 cellar: :any,                 arm64_sonoma:  "921bd939a2a850427230c4bd8d3d5cc7f09c63e44f8a5f93fd6119429fe69b25"
    sha256 cellar: :any,                 sonoma:        "325f1aeba456feb338c9bcd884b83b0afe3813600e10f0c55c96c2f6de2ebcd7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "63975ae7bde829a077696191db71ce42fbcc766341e91c2177bfc4d63934bc4b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7b22134d34b8eaba71f7b38ad569dbc153423b47036ed40db59d79b90630caf"
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
