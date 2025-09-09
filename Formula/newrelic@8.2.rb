# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "aa0588bf64de1d52fd6dc0cbce36c7f23c182d94865e64e431d77a06dd0e69f8"
    sha256 cellar: :any,                 arm64_sonoma:  "a854c6b3a08fcab35d91b3c3213ce4afc8f8e8e9353c0bf91cf449d417ebb8ea"
    sha256 cellar: :any,                 arm64_ventura: "8f08febef9c4a0456b555bbb015a7a0975b48c71f6697af20ce6515daffcfe18"
    sha256 cellar: :any,                 ventura:       "85015ffdb8bb2798edc7771223a92f85b6a2130c0afc83619ed38f5570e46ae6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c15b87bcb6e5cc3cf1e787a065758667693cefc398c4993ca51989fabae577b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8fdfbc0e11fac97efbf983827865474bced1c41a9da5aa4b887de5653beb658b"
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
