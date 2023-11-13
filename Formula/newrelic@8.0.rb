# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT80 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v10.4.0.316.tar.gz"
  version "v10.4.0.316"
  sha256 "84eee1791051dafbad6627134dd052cc89e6611b175fda7808a65786938591b3"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "a3dc2936ad8f1a545fe6b49312ceac0d799263aa5375cc4f13b035d812d8ee26"
    sha256 cellar: :any,                 arm64_monterey: "7a4bf85dbe1038e2d3e163c94381baef1295d07b3d525772e09f850836b65c03"
    sha256 cellar: :any,                 arm64_big_sur:  "8990f961183223c8f43b42cd0055b95258826ce8e4484f214e48860150ac8091"
    sha256 cellar: :any,                 ventura:        "fa11b6108a73c9b30bf7b4dcbb50d4723e0122496cf06d25cce022c45f2dfc6e"
    sha256 cellar: :any,                 monterey:       "643a3c1287de199522276af033bbecc4661d8dd0458396a512f2c4491b624261"
    sha256 cellar: :any,                 big_sur:        "20f52f3ebc0187b9c499dde86bb8faf709b5aea2e78adfec4e0761b7b9d5038d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "72d21b4b2055aaf5b48282e95503fd3cd0c468e9f07c6164528fb73c7f1e70c4"
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
      newrelic.daemon.address="/tmp/.newrelic80.sock"
      newrelic.daemon.port="/tmp/.newrelic80.sock"
      newrelic.logfile="/var/log/newrelic_php_agent.log"
      newrelic.daemon.logfile="/var/log/newrelic_daemon.log"
    EOS
  rescue error
    raise error
  end

  def install
    inreplace "agent/php_autorum.c", "return (char*)emalloc(len);", "return (char*)emalloc((unsigned)len);"
    inreplace "axiom/Makefile", "AXIOM_CFLAGS += -Wimplicit-fallthrough", "#AXIOM_CFLAGS += -Wimplicit-fallthrough"
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
