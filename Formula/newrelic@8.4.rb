# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.8.0.37.tar.gz"
  sha256 "0fe3a49170310cda15099d79b9ed6424cc653656f8c8df9309b56edcd3798e31"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ba14dc2525ce177d07f718726042492690f827ac9cd90372d288534270aca133"
    sha256 cellar: :any,                 arm64_sequoia: "ba095e0155d06a956b87e4c1d94eb0690d273c6c447490ce39d3e678eb33f0b4"
    sha256 cellar: :any,                 arm64_sonoma:  "305e4af1240b4e97800c615b5b606c980825a2ac2589237ec55993ce17b1a40c"
    sha256 cellar: :any,                 sonoma:        "0eae2b91f77720d26d3489d4b9e1c432dcad3d76259444f54c191fc0eef1c0e1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d04a3a5884c4403965f798bd0bc725536642857d58c0454e0c4645daa9c7e5f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "11f32ee88ce5b965c317bf24657ad8eb4d0691e05c6cfbafde18ad6d07c25ece"
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
    inreplace "daemon/go.mod", /toolchain go.*/, "toolchain go#{Formula["go"].version}"
    inreplace "agent/php_txn_private.h",
              "nr_php_txn_get_supported_security_policy_settings();",
              "nr_php_txn_get_supported_security_policy_settings(nrtxnopt_t* opts);"
    system "make", "-C", "axiom", "v1.pb-c.c"
    system "make", "all"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
