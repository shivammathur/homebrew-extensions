# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "967e8ac162bd6c72caa4bb94e8d09f627ba6f3e43663f03f2c57f5a365d4aec5"
    sha256 cellar: :any,                 arm64_sonoma:   "49eacc577eb0e8ddf24be7a50b927efc42f76a650e9b4d25d1c21ddcc034c8a6"
    sha256 cellar: :any,                 arm64_ventura:  "2db417ad603938b3511f2a38814e109feb2757eccd0d22b08dcc5156c20dd9c7"
    sha256 cellar: :any,                 arm64_monterey: "5c29b08e7b73f31f564a45d9e8511744f017fd887693c85b6363678042e67fa4"
    sha256 cellar: :any,                 ventura:        "77b13a995ac0813496d1e35c1bd901155016e5057c61eca014b136423ba07ff1"
    sha256 cellar: :any,                 monterey:       "091263b43a5c66fab8238c330134e736fc93d21d7f4b29ff0c398c5faf398a6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "197cea3fe9d256d74bef5e73fbe6b70dff6efaae4eee704e3825e35658b715d0"
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
