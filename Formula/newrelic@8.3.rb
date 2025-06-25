# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT83 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v11.10.0.24.tar.gz"
  sha256 "eb9b68f976ae88c642f753f1c51b4813d0fd63c616eb2f96ec94f7efd50c2244"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "bfef24d79fa78c0e3fe85da6be447c4584eff0875f68adfd1cb24ed736a1e2c3"
    sha256 cellar: :any,                 arm64_sonoma:  "b8cf634219b83a38844dac508311f1e86a6af797f6dcb89ea1f9cc15bd7f258b"
    sha256 cellar: :any,                 arm64_ventura: "9b769922457d1f0a30876479968abc68b46bbd8a0b244f59343121c2c8e34744"
    sha256 cellar: :any,                 ventura:       "1364ade2758da17defc1ab03fe1ff3ddbf5dfe87ab75292de2db3b13fc63bc29"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3615f3cdf376fbddedf48b4f456966438e332dcf8d2a86319beaa6832eb5851a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "017254e29446b8e3cea9bd3f76058c14fe6ba11f51d57fd22da0e02548d7694c"
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
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
