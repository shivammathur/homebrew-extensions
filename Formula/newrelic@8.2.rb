# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "50791e422f8aecf6b42a20678d5c5b1815bbd1f1cf3e80f75b61c372837c4833"
    sha256 cellar: :any,                 arm64_sonoma:   "ab23b981ed6bc4d329ac430eda4e733e0bed5b653524e1200c8a6d91c585fff3"
    sha256 cellar: :any,                 arm64_ventura:  "5d88d199f793c8ae79788dfb4cc422636a1a2ff97df6d47fea6f305ecec5586e"
    sha256 cellar: :any,                 arm64_monterey: "30afa1cec637128ef852999afe55ec130a111bae27c52a814e88b9fdae59ac24"
    sha256 cellar: :any,                 ventura:        "85645155c69bb11fc4332ef0360aa3430ba17645c24c9ee7cb5667165b768b01"
    sha256 cellar: :any,                 monterey:       "f55e8a39019aa14264e1c5b9652603e4dac220b8b9d2d02b63b6a054c42cb79d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0691af5bdc69d485592551daebeac6b8b61e1d38e93abf84876bc03dd91acbfd"
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
      newrelic.daemon.address="/tmp/.newrelic82.sock"
      newrelic.daemon.port="/tmp/.newrelic82.sock"
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
