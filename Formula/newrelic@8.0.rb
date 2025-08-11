# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT80 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.0.0.25.tar.gz"
  sha256 "43310e8999ee11ff97e8573eb5d1e6f9ffbc8caf9c76960cdc732f413353276f"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "31df8f8c58e71f83f56ec0e024181d768dd0b6ede3ed7955718c08b8f5aef999"
    sha256 cellar: :any,                 arm64_sonoma:  "0292b9299305a7fe0ca10415aa61b9f110b868c0cbccda204d7b75e4e8a688e6"
    sha256 cellar: :any,                 arm64_ventura: "cdaacc3ae95290551c8ef596343bb96093763b6886685ddcbf56a54d569c9b2b"
    sha256 cellar: :any,                 ventura:       "5089ed77023f8db23eaa920f4ec398a521ed0119c7d939cb03584ad0b98c3ded"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5f76791d82515a554a1e2849fdc07a198c35e87457cdf6d0f091ed3b3e231db2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cff62d2c511027f3f2acc5e05c4d1c49a1c43fd22ba9e5f34d4afbfb6518a837"
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
