# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT74 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.0.0.25.tar.gz"
  sha256 "43310e8999ee11ff97e8573eb5d1e6f9ffbc8caf9c76960cdc732f413353276f"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "3c0705ed76f7d3eed27aaf81a7d2ad7654e1f1fa72da47a07d0b503f7e4c2a57"
    sha256 cellar: :any,                 arm64_sonoma:  "83566dc65d0184f9ddd9bf2934b0573c30b5cb38a273de093709e15e6090e3c4"
    sha256 cellar: :any,                 arm64_ventura: "4155cacde4110851871c531619c112cdf7780f7703a38830ac8584a8a09f2c52"
    sha256 cellar: :any,                 ventura:       "643be4103120601290443a599e8f733a26654647237fecde4da2001ffd7eaee4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9e22aa74cc7de0008fbaa3506fdfaaf38b63fbfdf1d560046879b02b8db3dd10"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cd157571d7f0e3361f0a6b5048bcc8d1b3f81c41f917b184faf30eb0825b012a"
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
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
