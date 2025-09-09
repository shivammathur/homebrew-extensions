# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT80 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.1.0.26.tar.gz"
  sha256 "ecf43411df96f90bfc2fdc9a4a8a6c3bc6ee4d602e09b8d5b32605f290bba3d5"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "f6fd90e18997940c25d90a54cb926cb4cfc898f8e8724b117293956f504e43f7"
    sha256 cellar: :any,                 arm64_sonoma:  "b2af15dbd2e8262dff4e92fb786f67d787853abad6654e9b1cf4596354b3bbc3"
    sha256 cellar: :any,                 arm64_ventura: "bcabd02003e1ae9b9052763d889caaa99c020e226cc3935cedc3db50e65c7950"
    sha256 cellar: :any,                 ventura:       "7443801bfc7bcdc3f134cfc1431719413828cb03d2b12da39ea55387a8c80398"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7a07e9d294812ca8007cff873bde165fd7b0a805b2e629dc5749da78c318703e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "36efa11f0fc3b816df93fb0f310e1576088efb48ea6bbcd7934b96f717b52e84"
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
