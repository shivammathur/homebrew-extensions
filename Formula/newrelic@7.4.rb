# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "d5c0610815bd512b23a4f6fd7e45f5580609c2dc4b342734b4976008f03d70bd"
    sha256 cellar: :any,                 arm64_sonoma:  "5d319e541ec41ae0953be1a66661d8fa10d2957298d4e95990e37b667821b409"
    sha256 cellar: :any,                 arm64_ventura: "eb1bb0061a489c5d92d3a0af0bcd0ddbb744db394db4730c97d0aeb5a2cbc979"
    sha256 cellar: :any,                 ventura:       "4a2d0443cc287900fa482320221300419efd6facd2c82e500202038747883d82"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4d079c81576ca112860a792af233a894bb586480ed8f4a8ab1a80c304b2b044a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d59bc362b8ad3b68edcdbcdb211d514491fed064f104e44d0b492b24b76ce77a"
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
