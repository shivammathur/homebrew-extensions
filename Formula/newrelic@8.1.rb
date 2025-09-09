# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "4a58476d76d90e6b6c248d2174ab17453e2e2d6cacdd66ffcc59934a295ce361"
    sha256 cellar: :any,                 arm64_sonoma:  "6eeb1d88c337985041609fba0e35937e1612993dd6189fe56e03242fb0c46f15"
    sha256 cellar: :any,                 arm64_ventura: "5220278a8f37e0930059b9a6fed17769b32ab96a120093ca7c9fda3beaae3aec"
    sha256 cellar: :any,                 ventura:       "c50faef99a543e39c8c0112f94e35d687b6ae15bb1f815613a2ff813cb6d4ffb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5633aa9669830f34151ed691b431ebe18fbc4f9aaffa9788bec87052e3c323ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "70431ef9cbd7ffadef1f8c57faf81e7b960e55d9131060001afe439507f16da6"
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
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
