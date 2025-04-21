# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "56c14c163316b28d60024b08eca6f02b6f32db1b6e7a706ebfb661820e5ed932"
    sha256 cellar: :any,                 arm64_sonoma:  "99ac13b48b6fabe84d0d52def9b1065cbbd52314dd805bca5b7bc96cbb0fe07c"
    sha256 cellar: :any,                 arm64_ventura: "b192c294529c1ffc595159650aa9a7d74608a153d6e12b43c6c6383505595654"
    sha256 cellar: :any,                 ventura:       "04c5910cfeb2cf43ce05b193e71d49afd59a9d035da1540f7f5b595b09b71ed8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "caa759e58464b0ccfea3cca9f7e35ecc7f2ac44cdf5570322eadb7a9ae1d89bc"
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
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
