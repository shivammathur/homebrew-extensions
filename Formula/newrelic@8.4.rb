# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v12.6.0.34.tar.gz"
  sha256 "45143e55f99a615163ba9281e7c7b8e8b27589d891dfa9ee77ccaba2a3f97583"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "3eb2ab8b8f776bdd1e1f48bc786c70db8272a38e5f3ad89ed22da8fd0932aa5f"
    sha256 cellar: :any,                 arm64_sequoia: "f9ee89dbcc8e62b6c1afaeefaa621028084f377ddd9d1ea29f171fa02ddc82d8"
    sha256 cellar: :any,                 arm64_sonoma:  "bb1a975af45d9c477d3388fc44bd9c5add568112e3d6789d284443005772562d"
    sha256 cellar: :any,                 sonoma:        "d345f21b2ffb9c7b27af85343c2872bdeae604c82bb3b27f2a43e9dc1b17cb89"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1410bef8661c1561fb7421c1c82434d7464812c3c37d564665ccbf4664f68f79"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2fdf0a11ee007d0d52da2ef7bd5b4d7a3e460603ab4ace5100ca71b833dc97d1"
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
