# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "1c556be39dc1b580868377e97f025b1ef0e5eda4e41d596f717b9352326450ca"
    sha256 cellar: :any,                 arm64_sonoma:  "1bb7e6b386938be5b7363ef33b399981862a1b08423d234662eb7db3c7843117"
    sha256 cellar: :any,                 arm64_ventura: "116f81b974c1200ee7712507f8ae98d0e00f8e31e9b577c6d3e5d61bbab49ce4"
    sha256 cellar: :any,                 ventura:       "7eb77481d8fc4a4b76f93e2d8474625c4055beb6c3f86b5bd3e905b4cc6284c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b72cfe4b18f4e803e12e586772a1247b566123c8aaf3711ba40825ddbdf34b3d"
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
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
