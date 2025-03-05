# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v11.6.0.19.tar.gz"
  sha256 "3b28a421ecb2c2215c472c374d5fa37ed5d48526f1ab2ec1fb9d7768f8ac96fa"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "b56785dc35a26ef95b446984c26b6f713d4646f723c4945d3e5b943fb00557c0"
    sha256 cellar: :any,                 arm64_ventura:  "efb4b095c20d835d090633d3c96d39aa31abe223ecbe957d5131bd24aa6888bc"
    sha256 cellar: :any,                 arm64_monterey: "6ab93ca14aa471995942ce39d5beaceb5a692253e8791189145d9988b367844f"
    sha256 cellar: :any,                 ventura:        "b73bab6cd8dd8485b8d54b0d109fc4018fb86dfd47a50c733887d1508dd1a1d6"
    sha256 cellar: :any,                 monterey:       "83f70226ca23e5d870b944f3d48c87d34ba5bc654ac4c677c35b8bd0903ff2ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "24d698fbfd765356b18b4cb20c93699ae0826ec974327da45781d53c0b8422ef"
  end

  # for pcre_compile
  depends_on "pcre"

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
