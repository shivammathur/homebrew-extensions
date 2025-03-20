# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT80 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v11.7.0.21.tar.gz"
  sha256 "b88a86c0fa2565d0be05602b3838f917d19e10ab80f0ca2cebdd5b8e3eeb210f"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "023032c9e042afed59645579ba254bd0a5db92c0fabe9dcabe65ac5126d96850"
    sha256 cellar: :any,                 arm64_sonoma:  "c0dc6b5bf32ecf47fb721708c9b87b30f55a6d622ab91ec0506c01ef6756f40b"
    sha256 cellar: :any,                 arm64_ventura: "6cce6be3492240c201fdc0d8ec3a9d2b2e7f109a02ef3907ff18c13b80b81f75"
    sha256 cellar: :any,                 ventura:       "935cbb1c786a371c5cf18aa3e6b94b27614dbaeb4d5fd030803884faa2ccefb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2d2ebc683b5b6aefa5995f0ccf3f63c0575a142513c0c4b1aa0f1016cc3828aa"
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
      newrelic.daemon.address="/tmp/.newrelic80.sock"
      newrelic.daemon.port="/tmp/.newrelic80.sock"
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
