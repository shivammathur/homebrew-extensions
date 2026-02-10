# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "6eab22e817ba07a1c1269b24b2e59331ee7cc53f6e0467a1bd2eca522bae6e34"
    sha256 cellar: :any,                 arm64_sequoia: "640b8d7f1d7aa2e763862eee5c6e77b0ac04a9a9d49a5c062986bc6a29391245"
    sha256 cellar: :any,                 arm64_sonoma:  "5b779a3c1011d3c433435a17c38f13bca913da8605fd2029c799e0bce2a2cbd1"
    sha256 cellar: :any,                 sonoma:        "fb1e2d48f93d256dff588a71acfaa08056801e9211c8c6e890f4f1d5cd1a370d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9e6a243e44d939c67017c4ccaf9675b461942dd5e602ad774ce3afdb2bef48dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa3f24e4a4c4104387aa800f7170f70ef3d75c52a86ab7e025c95713befb0679"
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
    inreplace "daemon/go.mod", /toolchain go.*/, "toolchain go#{Formula["go"].version}"
    system "make", "all"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
