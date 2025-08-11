# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT83 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.0.0.25.tar.gz"
  sha256 "43310e8999ee11ff97e8573eb5d1e6f9ffbc8caf9c76960cdc732f413353276f"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "f6d294c659705c31ba646b4a24e64d9b0aaa682c7d0303b46a42c0ca8a40a0c3"
    sha256 cellar: :any,                 arm64_sonoma:  "aea678eeacee61bdc7b3297077f92b635dd3cfa67a17fec81fb1df236eea2ee4"
    sha256 cellar: :any,                 arm64_ventura: "37877b8da3d565a436ac2d936b9f0b5c4fdb50cdb5034c4c8384fd7491d573d1"
    sha256 cellar: :any,                 ventura:       "03947c94a416d69bd3e8290b1594ead65ab51bd033f08743970c2044b9adf1af"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1882c6bdb0d05d2fa5dbcf65cee2a6b217e36a4dfc107a22b0c15c8cada2e5e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "644e35d341fdcd7c012dba054dbc1ff3c9e2dfdbfcdd8c703b64ef912987a2e0"
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
      newrelic.daemon.address="/tmp/.newrelic83.sock"
      newrelic.daemon.port="/tmp/.newrelic83.sock"
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
