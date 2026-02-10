# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "480a903babcafe04dc93b1ac4dbb0b39369f8d876fb904e5711684d83b3d22a8"
    sha256 cellar: :any,                 arm64_sequoia: "6cec0c5363284e5e209c0a4f5d16fba482faa623111bb9444db4d931b855bbe1"
    sha256 cellar: :any,                 arm64_sonoma:  "76ce21aeb8314ef8dc8a3b9c7e601e122fb86165649476d956e1ea77a718f5c8"
    sha256 cellar: :any,                 sonoma:        "81963c3245658c1cca541e2b3dd241a61cc86dcb4d17e55016cf9f1ebfda9015"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "66c0e20f4ffa19ff4873cddc7d7af55d9b165d0769a3ec569bcdb1806c0ca21e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b71eb1518d90078923197bcaf7e2ecfdf76ec4254a8ef6801f24ab023669e43"
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
