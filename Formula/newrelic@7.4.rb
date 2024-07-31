# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT74 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v11.0.0.13.tar.gz"
  version "v11.0.0.13"
  sha256 "69f72541acf03e63a4d7d4a1053857b009279d1c526c9b68ed1338670a9e2cc0"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "1efb6d11ee54e172e227e95326ee98ec537a0afa4cb2bf6af1cbdda3909d8756"
    sha256 cellar: :any,                 arm64_monterey: "5529686047440f3398748541a3c6aead8b9ce3b7802fba657e56f1b6e974a5f1"
    sha256 cellar: :any,                 arm64_big_sur:  "cf86a0607e58b9953f5cbbf902fb8a0a3eab333aaa90e7fc0a6f312215526a9a"
    sha256 cellar: :any,                 ventura:        "7e2691d6662c1e68b8ba19cf940b83c321001031b5cb346d58173757875c0460"
    sha256 cellar: :any,                 monterey:       "f6371a241492b7e86b15b786a55abb695f9abc9c4ed6c58d09e118a2b7381422"
    sha256 cellar: :any,                 big_sur:        "7dc2a7dccbfb9bd9c0c4afc2578e27ece5563806f0903c5184a219311c0c4860"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6a0beea57b29ba017347980c49be711f51002b551beb56fdbb83f1e131a7df06"
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
    inreplace "agent/config.m4", "-l:libprotobuf-c.a", "-lprotobuf-c"
    inreplace "axiom/Makefile", "AXIOM_CFLAGS += -Wimplicit-fallthrough", "#AXIOM_CFLAGS += -Wimplicit-fallthrough"
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
