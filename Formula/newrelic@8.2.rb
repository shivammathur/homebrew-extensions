# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "359394771ec72a285994b2092e2317200934fc77176422721fc4493ffe3b2c92"
    sha256 cellar: :any,                 arm64_sonoma:  "ce5d2e0025b518ea7fc3d39ba46b2c9995ec115206522593c6042b5b954dd99f"
    sha256 cellar: :any,                 arm64_ventura: "5c819aadf8cf64a93ef7865e31feae08ff1932c33e340da96e958a0ca4c30bc7"
    sha256 cellar: :any,                 ventura:       "82ce51af7fe7fd95599ee1e4d92b18f0e07bdf9a0c9bf9d11774782040e8e2db"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "115ea1175dd83e32da56fdbb33a8f4a02d5a48c6a99af87307b9ccd31d4368f2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6485d1e828d2a822b1b4f2c5a344a0d7e9b21a2053108e0f7896d5d4b56c4577"
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
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
