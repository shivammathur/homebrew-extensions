# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.4.0.29.tar.gz"
  sha256 "84ac7fa82d4382d687c769bc5a1d27f00f002394bfb1b6e4417184959bd2ac86"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "377cacd9c9b80c64be66c2783dc9d75b55914b45f07761b451c658e622df8baa"
    sha256 cellar: :any,                 arm64_sequoia: "4da202c15d494be54c7752a1da5faa007ae4a1b9635295c178616ea3897b986b"
    sha256 cellar: :any,                 arm64_sonoma:  "d728b15dae47605c24862fbeaabcd73c46b32e764857647f4a481accf3352723"
    sha256 cellar: :any,                 sonoma:        "8e15b85721777fad31558f650946c97a5a069a75431da79646f19db0f3fbb97a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "553e7d512a24ebc2a5ece1ad779981abc90f2b0e48e97185dfac83af98c97fd0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6235a62d5fe5294c904a462d109dbc81e9871dab528df9f266359895fff2187b"
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
