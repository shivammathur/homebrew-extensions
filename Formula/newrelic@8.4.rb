# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "a86c8506d783283dec508916fb608fe37b65e04b07a04a74b042eafd63fdf0c1"
    sha256 cellar: :any,                 arm64_sonoma:  "7b007bd66e55e46b74b4e6b5f62ffd1364bcbe6bcaa9e8265fdc866cc67d51c0"
    sha256 cellar: :any,                 arm64_ventura: "a708b1c6b3248d313eb6e8145417841df5a60060b37ec56c734ead8e4c27d41c"
    sha256 cellar: :any,                 ventura:       "01f2adda11f22f4df27fd2f132b2ed34696bf9380e1edbed76f219145fb06bd9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ed434cf9cf716841401bb14a585eb89d8a7b248f5ac4326d2970168ebfe955c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "43561e15bf4f79bc084dc22b74ec0a5d701d4953fc96f371462aba1e3af72802"
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
