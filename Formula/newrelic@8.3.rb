# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "02ae899d21703c906f6efe7dc102029d425eef3108a391c89c07df1597bd7104"
    sha256 cellar: :any,                 arm64_sonoma:  "4aefcbc0c8427ecefbba09de9955f9a3bd4702f8049fe4e801ea0c16654d58e4"
    sha256 cellar: :any,                 arm64_ventura: "04108f787c2ca61e7ad8b234d4b8d40fd7ef3705261a7fe7ef64413eecaa8e89"
    sha256 cellar: :any,                 ventura:       "d7890326d4fd895022bef046308f743f698cdcec0021f55da217f6e2f44ee7a2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0e5c780fd40322f08f15ae9d2a3bb4879d84da177647a1f96622faac424f1d69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "476f3bb34282d7a2fc3af5028e422b9eaf89a72be4524eed7fcb1800cc786bde"
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
