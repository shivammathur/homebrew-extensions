# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "95727f8fa209663087e55c7d0966830205b24dcc3395aba6e538811c6a3d0d3f"
    sha256 cellar: :any,                 arm64_sonoma:  "e6740e71f2fb88865eed16e1242da8ac80f52271dcb1a7742a57518d3659c73a"
    sha256 cellar: :any,                 arm64_ventura: "1edbd1970c693d7592bf9a0b65cc1ae7711afac8fdec9e97bf5a96d535ecae57"
    sha256 cellar: :any,                 ventura:       "167a4bc25c9e62fdf57b267cbb42ebd950aa0460735ea09d4756b47b4600dd91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3a04f74da95d5c2722fe1e2e5d9efdaf124f35450cca9af310792c772082a897"
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
