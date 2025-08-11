# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "e675de78ffb747eed9b7e4f29cb81a1844fa880c88edf03d1bce09f6a93bda8e"
    sha256 cellar: :any,                 arm64_sonoma:  "155c4360a84f65a3d066ecf167bf3a77a4504702136eaaf806d3c0431e8bfc6b"
    sha256 cellar: :any,                 arm64_ventura: "ba90c2fc928a1098ebb9e44f617fbfe4dbfe14e599b6bbbdc24c693253ca267f"
    sha256 cellar: :any,                 ventura:       "d299c4d08da18bd3047e853a7234052bc3a8fa1ce7217bd0f87c1f227324e8dd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a84b5eab4b31fd331d5cc7a562ba40d510eeb27012d9af3989b67059377db43f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8415036a2a4b148e57c0802fef10810ba73b0a6a87827d25382f9e601505fbc0"
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
