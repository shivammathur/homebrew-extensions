# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "459d65612a7522a3e0a1684cb5daaff088d6e0ef5a963fc8a0f6be184c46098b"
    sha256 cellar: :any,                 arm64_sequoia: "8a8e02ec00ebe655286403f48b8d733187a2696ec442664ac64a1ae75b9b252b"
    sha256 cellar: :any,                 arm64_sonoma:  "07aa31adcd0478899403d5bf570be11896bbb203e57248b753cd74b675d8985d"
    sha256 cellar: :any,                 sonoma:        "698a832f6437c0ec73ed43cf29483b647a2c72e170c1d718be0f3a90cd5a7def"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c700af71a164d2d5dac5ee66677f71e6708843b6ba3d742120d446fda4bf0bec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7161e603d93dfd0599e081ba71201e6f409484ab7bc29534051c7ade4ac9c2b0"
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
