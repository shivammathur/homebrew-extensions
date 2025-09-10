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
    sha256 cellar: :any,                 arm64_sequoia: "1db8de2dd13ee6e31afca38e85d0dcd2592bdb6d6de044467cae9ad85a54ae06"
    sha256 cellar: :any,                 arm64_sonoma:  "c6e4eae33b8a089ff1e771c77e7dded7fb500055da2affbe733a532df4ed45de"
    sha256 cellar: :any,                 arm64_ventura: "37f3734f96ae34cae079825ade1afbc71ec251aceacbedd158a3565a5529af37"
    sha256 cellar: :any,                 ventura:       "0e3c18a275bcc3fd721ba404b40ab894dccb49b88796926aad9f2de4d9c2f5ba"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3ff2bf2fabfa62c1fd287d01280dc3a42b576db7cc5c0c93b9ba13e8637d331f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86c6a229898b83d7633c93410b3d366fe2f7dabb789f7a21e1c8087fdccbced4"
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
