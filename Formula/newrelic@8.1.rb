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
    sha256 cellar: :any,                 arm64_sequoia: "10dfae2008b4ee6408e4b2c0ed6f96ec41e21094f7a61bbbe901eadf9231759e"
    sha256 cellar: :any,                 arm64_sonoma:  "9cb78d758f4fc3e7f951c21368d9ebf966da4774ffc829b3760b39dcee4d1e63"
    sha256 cellar: :any,                 arm64_ventura: "e6194c3faa9c9bf43694a28e9624a1a828837bb001ff4e0517dae91167092e4a"
    sha256 cellar: :any,                 ventura:       "8c5570dd851b1ec0bae51684b123ec08559d6ef03c29d460cde0ac7e325915d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "68b480d09517492284b3fe80477babd47b1361bfd977ec1d5b0ed8246b170782"
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
