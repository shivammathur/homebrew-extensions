# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "52f722c336258c920399b2735f9a4f6aa0e573d9ddc42877a43a20ee78b753b3"
    sha256 cellar: :any,                 arm64_sequoia: "ae989d58d6512e7fd100c1cb7db43c9b58ab04051416206768e71e0ade1a8ccf"
    sha256 cellar: :any,                 arm64_sonoma:  "49aa2898b5461940c4f26704bc374adf3a945af6dfa3bd653aa82e96778601bb"
    sha256 cellar: :any,                 sonoma:        "833384a0cfd34d3cb2675f4231bad71155f9ea87fd9b200bf8e0838360058f13"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ee79faafcb64c8090c26c653ad7a37d123a4d3e57ff438bdc5882d29d8bfffc9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4e5b2626e05df08b88e2a44910469fb4b23ce8963b60efa6bcf426d90725863"
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
    inreplace "daemon/go.mod", /toolchain go.*/, "toolchain go#{Formula["go"].version}"
    system "make", "all"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
