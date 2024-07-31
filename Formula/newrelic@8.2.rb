# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT82 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v10.15.0.4.tar.gz"
  version "v10.15.0.4"
  sha256 "8ffb3d377ec8632a5a873a1a53614b73027c8a3fbebba29c3aba956635578e01"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "3310b88541000ee3e89b011960755c7984c639289a4330b67efb216c35ec9d71"
    sha256 cellar: :any,                 arm64_ventura:  "2125a1797b2353b6a3e8d0f6a7fe407d084b9302e08cf034fc5b13ffb4cbdb70"
    sha256 cellar: :any,                 arm64_monterey: "32efddb693e4b04c9b9495a5eff12c5833e7ea4626e444676cf74d13465b4a99"
    sha256 cellar: :any,                 ventura:        "22aaa666486e15aa75971ca608570df33b1f65a7812a6d1340d27a8c2a4a2281"
    sha256 cellar: :any,                 monterey:       "c98db7b14b109df4a52980b79388cd1febc2e2f115411880654577fef208dde8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2591222efe541501d9fb40a25d8db35307f2f87e2ae2bb9383a76a12ddaa67b6"
  end

  # for pcre_compile
  depends_on "pcre"

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
