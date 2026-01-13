# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT81 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.4.0.29.tar.gz"
  sha256 "84ac7fa82d4382d687c769bc5a1d27f00f002394bfb1b6e4417184959bd2ac86"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "df027edddb0342660ec196d574d0d652efe7a606c0297e8124719cebad19c5a2"
    sha256 cellar: :any,                 arm64_sequoia: "f3190b0d0226d86c9473c35ffaa4e19d3be057e44ec07cce383050e56b01edca"
    sha256 cellar: :any,                 arm64_sonoma:  "251b682d20c8d102424246626c4866d0ef777bb7e94edff82c3c93eb10e231c0"
    sha256 cellar: :any,                 sonoma:        "00192e6a9eb16172697d85782b611a757cebf3c3e06b84733ff72d1068befb9e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fc9f0706bc5b01f317f3a72b6ce7e27277dc33c3352b25677f4f1fe110d2c9d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "15fa9b0283d205604396f9c01c970d07a44643bba32b76509f7cc9f86ae1c60e"
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
    inreplace "daemon/go.mod", /toolchain go.*/, "toolchain go#{Formula["go"].version}"
    system "make", "all"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
