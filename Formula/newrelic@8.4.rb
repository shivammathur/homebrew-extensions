# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "c91bf7d0233df73c25583fac22af1d6a2667c85c714c0822a5a66877ec777e99"
    sha256 cellar: :any,                 arm64_sonoma:  "f8ec8377f057ed57987ff84d15fe790a49e905ffd0ad812f0baf5f992474f94c"
    sha256 cellar: :any,                 arm64_ventura: "a6e41f8fccdd8b7dbfecf25c28cb3006b5337f57b5278e7042d1cd127a87a373"
    sha256 cellar: :any,                 ventura:       "21f1b2e2067fa182f62e96a039fa2a93d9ab8d4138cdcff33472f41e46360678"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2fcad9e582ba64084bb66db9c7ba6820a457f45e2470f2eb456767106c6d832f"
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
