# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "28de4886c3f3e84156a35be58dee5914356b8350c71c2a39d7ef6643f48906ca"
    sha256 cellar: :any,                 arm64_sequoia: "3787f24d5a7d3bf2a75b4d71675421abcb6216c78e505ecb03ef1ab57dd0ca32"
    sha256 cellar: :any,                 arm64_sonoma:  "02a709c512332257c06ce72c9aadcac942eb1a7e87811d6579101d7ddc379ef6"
    sha256 cellar: :any,                 sonoma:        "f2b30045536193250204aa211e3187d401a87f18331e19a8cd57c00474a2bfaa"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "21acd38a6b357b8483bed3571707a3948ce3f3783ee018e761104143018a3fe6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "91d9604ec95f46ba920b0016e2694251ba43ea82c4949f7205ffff10e512caa5"
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
    inreplace "daemon/go.mod", /toolchain go.*/, "toolchain go#{Formula["go"].version}"
    system "make", "all"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
