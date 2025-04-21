# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT82 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v11.8.0.22.tar.gz"
  sha256 "8a02436a6ab5ad395e7a200c19fad23217fe72f2429da8faf0a292935a04e757"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "ef07fdf0918d7002d0cc8ab552a26061da165f1254b75c583c815f3c2bc4ffa7"
    sha256 cellar: :any,                 arm64_sonoma:  "21730594c9eafa1085e9649ffa5217beac26594d34d584245880470d4bb60510"
    sha256 cellar: :any,                 arm64_ventura: "c23601645e371022902f90a4108b917213124d0bc2dda4a246ba5f02cd561058"
    sha256 cellar: :any,                 ventura:       "83c31104ed2b7a442f528f5f98e05aab37b25cf8b63b78ed89121f76caf29666"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "818c29289c4a8e76864497562bc4da0e47153eae9b10225e4b5c87285bb73aa8"
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
