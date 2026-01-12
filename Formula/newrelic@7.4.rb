# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "2413e13d19a47544c628bbd720c69867708adce12b5738d62f9e06d5f7bcdedd"
    sha256 cellar: :any,                 arm64_sequoia: "bc310d68138626697ccb63e677f04e6e22364dbe699d960c2e540cc8eefa6fcf"
    sha256 cellar: :any,                 arm64_sonoma:  "b745d6eaf3adcea2295751158893261f668184d0e92bd9999723838f80309d76"
    sha256 cellar: :any,                 sonoma:        "f597d6bf513406dbf80b82f4e1a357466cb65a8599f03d498033ef1ec4b75e95"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fa61aab2ff477761cf2838a634330f7cc576457c1a626ba385d57d1c54a8307e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8d8a767cc6faa0c76e4b8ca7b18f0186bf40b93837215512952394b0a3dc07ca"
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
    inreplace "daemon/go.mod", /toolchain go.*/, "toolchain go#{Formula["go"].version}"
    system "make", "all"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
