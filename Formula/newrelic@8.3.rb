# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "d7670d699f7b3f8531339963368147af32843905a744ee0fe30d6ee17bd1c404"
    sha256 cellar: :any,                 arm64_sequoia: "28c5709efbae04aee1317c16537d62d141f30ac31ca316932fcf706e7a9bf9b1"
    sha256 cellar: :any,                 arm64_sonoma:  "91e63d326c18f0ad3c628888c178bfe40d3f6f0bcc2abacb3dcc44016158dba4"
    sha256 cellar: :any,                 sonoma:        "52d6d4f394dcd2c9c11100354d6256448fd91f6d6a0a94741b1d02033f963a2d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9a923d08cff68a21c03144738ca99a024b23fff4574a5f450070785a9a222aef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6804331e9c089dd4c92bd960a38912e8104167c090b067eff30da747b5d80aa9"
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
    inreplace "daemon/go.mod", /toolchain go.*/, "toolchain go#{Formula["go"].version}"
    system "make", "all"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
