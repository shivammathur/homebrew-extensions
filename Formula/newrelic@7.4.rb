# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT74 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.3.0.28.tar.gz"
  sha256 "8c3c613765f9960dccfd0df05f909d57b9d5d0491fbc0d3b5fb547d7ef6e3aa0"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "77f8b204452bd69644d648ba4317f241bc11f3baa6a58d500316ff31a3522adb"
    sha256 cellar: :any,                 arm64_sequoia: "1dddebc61abcf83255cb8510104c0d64a3474498f74952e1b8a94b0e7e42c401"
    sha256 cellar: :any,                 arm64_sonoma:  "d868bea62c4936f8d0fe94de0399c6c758baa3690eea3edbc66161ad070f4f53"
    sha256 cellar: :any,                 sonoma:        "6470fbc68b201289b0f1787fa64920a36130792e2667e7dfc31edb743b18fc99"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "54355ed2fb6bba11769c381b54af06c3b0b749c436a7c6c7780b1c6859d026aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c2babe283f2c1ebf81314f432b6cf706f47ee2bd150be47972e7eaa8e143191e"
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
    system "make", "all"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
