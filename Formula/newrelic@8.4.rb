# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v11.7.0.21.tar.gz"
  sha256 "b88a86c0fa2565d0be05602b3838f917d19e10ab80f0ca2cebdd5b8e3eeb210f"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4de6b97e7029458819c5e19c444887b3502ad57beb349582befc08d47da25f7f"
    sha256 cellar: :any,                 arm64_sonoma:  "f82c0e48789b0165b0c0e8d744c760c4f7bcd3c9d62b426361a2ac10be48fbca"
    sha256 cellar: :any,                 arm64_ventura: "dedfedb5c736df89c00acbbdf778103459e54b7bc411ce592bc0204bdd150f9e"
    sha256 cellar: :any,                 ventura:       "70ab068d5496513b376c15b947ecfb94efb2fa79672f1d1eb25b7680af09e397"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "959664e71cbb68765f2d61f80a3ebfc09278077823e5ed370a8e9309c86596a1"
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
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
