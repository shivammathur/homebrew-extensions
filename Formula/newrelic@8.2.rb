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
    sha256 cellar: :any,                 arm64_sequoia: "434df73c3e493170a76347e429e1727e5597017b12088ca3cf4ff699951c73e8"
    sha256 cellar: :any,                 arm64_sonoma:  "e8ac56220dab5941f75e1b8f898572a5e0292ac9cfa69ded8cba76f69022be66"
    sha256 cellar: :any,                 arm64_ventura: "c9c362c385156431ba285e258031a0437eebf98f805f949a0d9c8e8bcde625c0"
    sha256 cellar: :any,                 ventura:       "c657a7fd2c8f8a32c959a533f78e7f89c310d8f8c9d519e95c5271ca9a3fd389"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7197fa9e99181a48efd4265cda822fedaa832cfb9af2f0bb15e18377ddce1505"
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
