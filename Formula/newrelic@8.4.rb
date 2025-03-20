# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "f6cf123380507c719d562167b2429eb0c2a4c65c41df5b08c4416195cf82504b"
    sha256 cellar: :any,                 arm64_sonoma:  "dfa653850ab341fae7f5bff3776642b3f4f16658f2abbdcecaf94f87eb983a9a"
    sha256 cellar: :any,                 arm64_ventura: "3e9367e1fb2af2731771ba367c4aa5ce35a49c9e6301b9a0821e6bcf309fff8b"
    sha256 cellar: :any,                 ventura:       "331b59af4bfa20c82b5143523faefb415c43f308ec24c85cb2b4a2f7404f5a15"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bfd1943223a73ae9223ed424e02a41b98cdc64f9bda8a42ee8e4ed502c3f0d29"
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
