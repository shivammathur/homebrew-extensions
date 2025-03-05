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
    sha256 cellar: :any,                 arm64_sequoia: "6084400b2a3b78e80a329bf888e0d8074b64d22c4e1badfe814a2e8b4d6f4562"
    sha256 cellar: :any,                 arm64_sonoma:  "49656b1a90fd58e4413732ad2bebc42d127ede6cd6b7f99f0b42da574a9ad867"
    sha256 cellar: :any,                 arm64_ventura: "53b54d9bfc1bea692835f3c87d35d6ed6201c8a88089692e254d97c40dcf960e"
    sha256 cellar: :any,                 ventura:       "69327e262898bc20e2cfec2f3d234fdd65df3a27225a1e92cfa693b268f8587b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9846856af403349e7e8877d16ff7422bea13244cfc90afb2464940b216c016b0"
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
