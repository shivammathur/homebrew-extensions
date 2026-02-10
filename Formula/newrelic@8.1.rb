# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT81 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.5.0.30.tar.gz"
  sha256 "b860c84b67e4515f2afd31c0dee410c57d231d5ca443abf4d1c827492230ebc1"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "66b252774461f83f9d0bd4c77c0c6ff0579106525839bb8671b997b88f22d83f"
    sha256 cellar: :any,                 arm64_sequoia: "fd4b453fb46bda2ede7506756db7c31f6f8df1411e454151b1aed41ac07605c5"
    sha256 cellar: :any,                 arm64_sonoma:  "234ad63584ba1de700aec45640634a8460cf66e4461280cb427dcc091dbf4496"
    sha256 cellar: :any,                 sonoma:        "405e37713a20cb1573527b97858050dbdf83b50fb3d13957a12cfe7c4a2806fd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "456ac4113ad88afd2a5a9e7e200edbcddc2de4590bd8f2b2e739da6ff1d1321e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "21662641ad3a210ee1baa7a12fdf94caa0cc31dc7487d5a7c7de476c62b4bf77"
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
