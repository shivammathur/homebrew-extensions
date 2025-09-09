# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.1.0.26.tar.gz"
  sha256 "ecf43411df96f90bfc2fdc9a4a8a6c3bc6ee4d602e09b8d5b32605f290bba3d5"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "8f51154c5166f5bb82a24060b6df67908f6b5261e212864a5add380e90b532fe"
    sha256 cellar: :any,                 arm64_sonoma:  "a487e021efc778e5f17358bc40afe503ae7b2894fcb5e3c50c0074a95fa946f8"
    sha256 cellar: :any,                 arm64_ventura: "f51312153f8d73123f22037bc8a9abfa7732679c2e9a1e5459a511a6b3b5760f"
    sha256 cellar: :any,                 ventura:       "ce3123e0e4b455c9538cafec41e21f01c75c3d2724bf9434c9f4b046de198273"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "63f008bba0353cd3062b59aea0730d67001f58de358a8c2c8ef6771e83391e3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "456335a038c76997f1576ed8cb152b091a691e4947606457d0121dd85a705473"
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
