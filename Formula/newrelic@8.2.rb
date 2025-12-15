# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "2fb68ade9dec26bfe53096da833fafdb1a2cfbb8f460c32fa983ff10c0534238"
    sha256 cellar: :any,                 arm64_sequoia: "c8713bab7fe40ae818abdb09cf2daffa834147086f2b804c935c0720eab02f76"
    sha256 cellar: :any,                 arm64_sonoma:  "39c87c8aaef3cd418cd615badd161f3d87b583acec581ed806420093347367c2"
    sha256 cellar: :any,                 sonoma:        "cf879d702d563bdd9ec2acacc51b240c75d1b053d7fdac93e4fd46fd3b05e882"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cfeec34365c18e575f43ca08fa86eb98a6f45aac5f41cf9eb124e93fc92c7ec4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4ea0e558a64b77aa908c5f6c9987c2f90e45a05a1e042e799c36da9dc434de6b"
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
