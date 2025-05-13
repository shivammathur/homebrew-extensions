# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT80 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v11.9.0.23.tar.gz"
  sha256 "2a1481794a580dcd19a00ccd6b82ff56e1fd2acc31dae8d0306d2990afe5fe8e"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "f3dbc01a30077c4b6b4645b1b112295d90d6a0802347f3438bea29830c82a843"
    sha256 cellar: :any,                 arm64_sonoma:  "23050f34539aa587e82992cdff6226daf1b054b6fd30ea8a543029884ee703d1"
    sha256 cellar: :any,                 arm64_ventura: "7081a48e761b282139f9cb83d7717dfca6dbd13a5195520e201f63f9a192134a"
    sha256 cellar: :any,                 ventura:       "0783eabdb6bae15db8d9177228406bcf707b2f24727ceb805f001f46ae07bff1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9e74d6adb416bc3f3243e58fcb8e1413a2fb1719d0f1b466185d450808eb67db"
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
