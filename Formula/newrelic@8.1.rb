# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT81 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.2.0.27.tar.gz"
  sha256 "a327edbd0b39948e6108e1e4643bc051abf8d83fd9d83694689f6c5ac87fd288"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "892117da38cdbd24980cdc1a24a637cb1aef38d9f1e91b42f0ade4c80eec8324"
    sha256 cellar: :any,                 arm64_sequoia: "c6f6ba27d50337cb584168b7ea357e3d7d7ff45ced5ab9f8ede6424f09f18831"
    sha256 cellar: :any,                 arm64_sonoma:  "300626b504676147ab6c0c329c0aa5f9840989c51e3755f02d202bd768146d02"
    sha256 cellar: :any,                 sonoma:        "c5f8bbac9de28fec9b7ee92b24d5a4309e8b4cdad3ba0e3885ae46697169bcb7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6a26c02f9f4ac87173a590780ff66fdd0ca2f7741a191bd6a8efcf3bad866c56"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7d7564905cde91868186629cd9ac8d9a0e8e0372021f2cd5d26f735f3fd1245f"
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
      newrelic.daemon.address="/tmp/.newrelic81.sock"
      newrelic.daemon.port="/tmp/.newrelic81.sock"
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
