# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "b1a13fe24254f2fbf2bff984421c31f6fd51518c0d6da7fa82efbcb593dd9d8c"
    sha256 cellar: :any,                 arm64_sonoma:  "9edc99b1f9c2b19cdffb29c1833c5a3c60642a9a21c687d99e9e9581be4a4a23"
    sha256 cellar: :any,                 arm64_ventura: "814435c3da016d707bca2dc66149f3d06f2af8da95201a3e9c0167b1b4a45f2c"
    sha256 cellar: :any,                 ventura:       "f6510d2d2761d604c192c2100effaca68423264281999c12e67f64fdd4e69728"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f78de4e3cc01666ad714cf9604ef2b4494e3b2fcb2fe9078d964b788cedc3826"
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
