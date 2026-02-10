# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT82 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.5.0.30.tar.gz"
  sha256 "b860c84b67e4515f2afd31c0dee410c57d231d5ca443abf4d1c827492230ebc1"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "77823f8268af7a1284e6b7c836a2ad118bf828b6e87a1eaf221b6fb983da2dd8"
    sha256 cellar: :any,                 arm64_sequoia: "ea14fcf567157757465be7c9c8c5f5203eb3c681a358b77fd1fb78c8e3668b66"
    sha256 cellar: :any,                 arm64_sonoma:  "a12fbc2c23bcef9c9aa4084c859507d2d72d72a680b21fa462761888986121e4"
    sha256 cellar: :any,                 sonoma:        "7ed2de798f7d2de4155b35ae5640adff5f4e2cedb3a3bd0141ff99c11d4d784d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3b7731d8933ea91e11e35e5717ce7c577dc8b4c0221fa8e5fad5bf934c7de63c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6f6d105cb5b38986577d4158b876e686d32dbcced135afebdb956bfb79745f38"
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
    system "make", "all"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
