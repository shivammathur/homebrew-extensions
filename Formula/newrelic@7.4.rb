# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT74 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v11.6.0.19.tar.gz"
  sha256 "3b28a421ecb2c2215c472c374d5fa37ed5d48526f1ab2ec1fb9d7768f8ac96fa"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "f64f9db06b09f6f8a55784e8a9abc0bcafe33917e4423c143291f6ecc8c73893"
    sha256 cellar: :any,                 arm64_sonoma:   "66d40a339a025a8b7a9f47ace388dc1ca2adbe01a77f5063d52d16b0eda788cd"
    sha256 cellar: :any,                 arm64_ventura:  "173fae73d63f39c63d132f187c9d0122cc6a731cce9f008e345725f840841bae"
    sha256 cellar: :any,                 arm64_monterey: "69fc2d6ce6862327cade2ec04ae97db374395286c51724bf231a7f5e49100ee9"
    sha256 cellar: :any,                 ventura:        "459174b200b4ba4e2cb4a2b10f340bbcb6b5e570041f74e799f11b19e1f65c40"
    sha256 cellar: :any,                 monterey:       "72c73fd0af0e9a99126e1054ca43074f3292511d545a89e2ab930519aeeae7e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "86eb60a07944adb2e83a37ef694ed57b16b1e1941718e608e602f063184f36e4"
  end

  # for pcre_compile
  depends_on "pcre"

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
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
