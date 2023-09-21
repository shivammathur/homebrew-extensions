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
    sha256 cellar: :any,                 arm64_ventura:  "4e855dd29873399e69975c65589da82bf1c736a0cd1a255a3cd857d45861c3e3"
    sha256 cellar: :any,                 arm64_monterey: "6fbe83f17a3ea549317de4c8c75bc0a898637604ac41fb7bb1697b3e3895c9dd"
    sha256 cellar: :any,                 arm64_big_sur:  "6f73b6b7aca8a79bd584b2f9fdfe5e91e844b6eb79e222b61625f90f19bb8261"
    sha256 cellar: :any,                 ventura:        "7746347adc42171755a9f28a66a27036ae6e4d8a313b2ff0b3863b4ee757951b"
    sha256 cellar: :any,                 monterey:       "d03c92f6953c40dab0b07267ed3be2b4fa4db19dcda66d4bf7bc4a539e91336d"
    sha256 cellar: :any,                 big_sur:        "009d799761230579a009fae0aa5f802422770acd172359c30f7c94196276d93e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bb23f1c07b129b514e33de1275bd14df90f7f756d951e198a7e7b40336489565"
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
