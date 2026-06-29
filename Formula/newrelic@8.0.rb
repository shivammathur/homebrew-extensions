# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "8b38280f9e8056d2290347730ca0fc8894e3d0613aad81adabe3bc5948d3b956"
    sha256 cellar: :any,                 arm64_sequoia: "e70cb509e8d6b1c3e7110e9bf23412b61330157e9e2e371335454687783c02e9"
    sha256 cellar: :any,                 arm64_sonoma:  "176bf7e9304695dc02b200590afffc84cb6e6f8f2e43c75872ce8a34aa79f27c"
    sha256 cellar: :any,                 sonoma:        "8e456b007ceb345b1da0a55222bb9532ca2d76749f51cf7f760ed1b6b70e7c7d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e1714595a2bc25c8ba06ac9277cb010d295d55f60c6c0a5a342e1ffa600f662e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e144c2f0a208d372b0eaf3a467dfe4b5b5b9306d4a8c3961ed103f62203cbb3f"
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
