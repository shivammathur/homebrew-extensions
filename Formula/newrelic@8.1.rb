# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT81 < AbstractPhpExtension
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
      newrelic.daemon.address="/tmp/.newrelic81.sock"
      newrelic.daemon.port="/tmp/.newrelic81.sock"
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
