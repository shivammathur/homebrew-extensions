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
    sha256 cellar: :any,                 arm64_sequoia: "9152e5dacf081b6d15ff313f93cc02da4c5b2ec46ad8d32bceefdef704f80a49"
    sha256 cellar: :any,                 arm64_sonoma:  "832f1a26a1ff9c55e161191721fff23829b8ced3d69dc0a2b24b4472c9de0b91"
    sha256 cellar: :any,                 arm64_ventura: "0f0d338f373be2f8b96d6462e22734c95b3580e2127a45d285cdc60c0a78b585"
    sha256 cellar: :any,                 ventura:       "7b990ee773e8e7acafd21e4f44eb40a050e9d4363511cb5de13c4ef2c122a802"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7917c28b55e1d611d7103e41054a2e4db9e60e8ce8f75203ee84a28601435ce2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9589f600df42f5ea4d77e3c0040b9d42d5ac942d5e750500128d3ecdb94bb203"
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
