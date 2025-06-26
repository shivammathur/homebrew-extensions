# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "cd75339cccd9de22c0ab797a95e5ac3dfa91eb03a561f3c48d6114f52c8a773a"
    sha256 cellar: :any,                 arm64_sonoma:  "c49168628c26f362405a2a7d4b528cc37a11aab9ee66378e0abed6db03994f6f"
    sha256 cellar: :any,                 arm64_ventura: "9657dbbd8b2f2378206ae68354832e69ac2346c999f5ddfdfa3a63b1c478e839"
    sha256 cellar: :any,                 ventura:       "b9e4e04c882f9d7e18ad078a15bbd4da97730d39352e3c4bd2c4e4f904c0ded0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "01a99851f090ad70e67d7bb2d874871784fa438eaec57a738e427119b34ea4f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bdc3a6eb858e24c0cfcdad66cac79705d377bd867535fe5f9f45bc39cbafe0c3"
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
      newrelic.daemon.address="/tmp/.newrelic81.sock"
      newrelic.daemon.port="/tmp/.newrelic81.sock"
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
