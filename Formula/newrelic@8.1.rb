# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "eb286bed061da0f87f023548d9707c9d049479f6931c441a488f8f7b3492a26b"
    sha256 cellar: :any,                 arm64_sonoma:   "1fbb6292febe366c2e48d05adb89a2dc6c652db006921e8c34f423ff0d8f1708"
    sha256 cellar: :any,                 arm64_ventura:  "9d16ccd5f01fdd1038785fb8376ebae07b2784ded09b9f2c58ec26bc8a533e56"
    sha256 cellar: :any,                 arm64_monterey: "720c8ec4277fc40c675ca6b39babd7a89b01b5eec40111f64ce59ce79121356c"
    sha256 cellar: :any,                 ventura:        "8d9a7d3dce48044f5f9c8b7a6a07a78dc675d63a98899f996b2e6c80cc6bb57a"
    sha256 cellar: :any,                 monterey:       "557a5431a4dc9e74cfc3285b1fbc2df6c6cfa1ea6ad2e04bf2c44f9d90b83e48"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f9f66259d8efdeccf02ef7d06bfe0c2f49f882383cd9510f87365137dec71ec9"
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
    inreplace "agent/config.m4", "-l:libprotobuf-c.a", "-lprotobuf-c"
    inreplace "axiom/Makefile", "AXIOM_CFLAGS += -Wimplicit-fallthrough", "#AXIOM_CFLAGS += -Wimplicit-fallthrough"
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
