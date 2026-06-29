# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "8a63476f6bf31ab03a296d9bddd18b03555af3d5523e1ebc2a77df962043b357"
    sha256 cellar: :any,                 arm64_sequoia: "79475d4ddd491bc96c65c86557e8a81641bed8db9af6312fcc1391a6f8336e99"
    sha256 cellar: :any,                 arm64_sonoma:  "161d8d4931af82696249a8b9acb574b17f6d6b5909f8ddb5d46e0a1b60164379"
    sha256 cellar: :any,                 sonoma:        "0d5080f37e292082e9dc082f000bcc5e6db4e60eb0f94db3b531d2d231a8a68c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d22b68419de2f4f2358745ded397a32242ba0479df159608140eed255d46c957"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1d23a5b5785b03d68092d994302c5948d2abecf602176477372de3ec251042e5"
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
