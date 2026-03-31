# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "b9f093f747a83b4bb0b61c095f36821ed79095a31066c0574005531be35ed945"
    sha256 cellar: :any,                 arm64_sequoia: "03361114cdadb3dcc1a378a0ea1b23e9490f64403919c109ad45f0d3e586bc6d"
    sha256 cellar: :any,                 arm64_sonoma:  "c5f723dc6cb388023dab59e8f7c6718a5c56998da0f617c6f38a46f93230a390"
    sha256 cellar: :any,                 sonoma:        "8f04dc92ba805d7a1081a71c22ea1bdeac266b0e99f4ed981627ee520653f69a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "61f9298987cb8cac8682af896bccab2b3d8a20fc4ddf496058e9454d6bd93c47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5fb50fbf82c0a0df1688276364e1eba7a0370a1445d8b6fd34c0087e1db54583"
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
