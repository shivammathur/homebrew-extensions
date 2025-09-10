# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "66a3b0bb7fee8effd8f4c0617af2237028caada74fb29bcd685607409a5a1cd4"
    sha256 cellar: :any,                 arm64_sonoma:  "52a319d9153c51b5d7f3f2c60a42b15d9686a0b1f0c6ef5efb777cb6d9ace988"
    sha256 cellar: :any,                 arm64_ventura: "78867a24ed345b6312fce42d8f6862337c6e452fa7bfd97690dd29c69558054e"
    sha256 cellar: :any,                 ventura:       "312a13c53d339dc54ef27586f7d68fe8cfc7b6a44eb9f959bf80cc7c89c265cb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1103d8987b29e7096a6f2ab900d31878f716c221c9d9db5c5d78dcc63e62498b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d95a3196da1cbbee0389b935e06c4e3910024cc6755ae9cb1394ac129e8a4d4f"
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
