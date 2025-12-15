# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT83 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.3.0.28.tar.gz"
  sha256 "8c3c613765f9960dccfd0df05f909d57b9d5d0491fbc0d3b5fb547d7ef6e3aa0"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "912c3767d453f0093b017e33e6b085142f12ecf277f4379cd265dd163f4ac94a"
    sha256 cellar: :any,                 arm64_sequoia: "625c00d883c65ef4d2db5d8ba45b354cb63c768c8ac6feb77e02a76c64fe666d"
    sha256 cellar: :any,                 arm64_sonoma:  "2718eaf6f007ce7817334d2bb95c56c7d40c20e018beb474f7fe32fdd40585bb"
    sha256 cellar: :any,                 sonoma:        "cfa0411985e7df34995b8c4679d11774571fc28427b03646174208c8a21a6b14"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "571f854cbf86079d6763ef511948dae4ab8caeaaddd4f50994e0d9840fad697e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1d38a59104e4b841249ec0abb22bb58427204897c9662e1854f5f37a042e429f"
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
      newrelic.daemon.address="/tmp/.newrelic83.sock"
      newrelic.daemon.port="/tmp/.newrelic83.sock"
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
