# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "d0b3681912ab4bcb09d0ea470e1a7f79e11c614d73320fd24f1aabad41fd72e8"
    sha256 cellar: :any,                 arm64_sequoia: "abd5ee162d5226a87b519412519fedd8ab3137e5d72b16198c910519939b6f94"
    sha256 cellar: :any,                 arm64_sonoma:  "1461466f50f92e9ebc55be234e5a11a960ef43a0f56fb5a18aac8f3d0e3dda74"
    sha256 cellar: :any,                 sonoma:        "08ddcd3f005b1b6541ab1a79563ae0e61a31a531b69f9064fecdd723800513fb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2ae9f1162639e52d261a0419f81a0c223b23d123512663cbab2b26428b068d25"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ce6350a7680c0f5ba51228d70d865b8bb9a3559aa39c2a91a97797a9c1383467"
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
    system "make", "all"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
