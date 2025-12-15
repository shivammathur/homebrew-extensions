# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "1d588bb421cf8dc6abbf20aa7851503ab008d5ce9750e155e87c733c3cda6980"
    sha256 cellar: :any,                 arm64_sequoia: "8db851a43189d1c6cf84c6cc041cab0b7f16e3d5ca14aeb8ee5732cc7aaae009"
    sha256 cellar: :any,                 arm64_sonoma:  "0750df8cad1756242d1ed06a6577e991235e1082594018e71b762416f3ecce5e"
    sha256 cellar: :any,                 sonoma:        "e97f6c99591a9c9ab276ca9c1ee1d32153c9856f535880467db620e0959cd46c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cd44fc891cced7c84cc3ec57b06e9c52320bac337eacaf0aeb80689db0ae7cd0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5a51ead28e68291c8e0a4e3ec7c524edeb85af024b3a0425d658e6ab37d55584"
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
    inreplace "daemon/go.mod", /toolchain go.*/, "toolchain go#{Formula["go"].version}"
    system "make", "all"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
