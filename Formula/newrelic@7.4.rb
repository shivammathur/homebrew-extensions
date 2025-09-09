# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "b4b9b984c6dfb7e07eba7135172bd46dca603d20b85f790c79d125538bad3391"
    sha256 cellar: :any,                 arm64_sonoma:  "a486b13fdcf5bbd462750fb0293dee213f8345771b679e9f9d79d695151f7bec"
    sha256 cellar: :any,                 arm64_ventura: "45c7dcf1c68ef3f2ef3290e660b67e2483039f63b1cdc478afe16920ca758222"
    sha256 cellar: :any,                 ventura:       "381a934539a07b77448ded218609c7a4c6dcc92d73d5f8b9684408255911d8e0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6aaa69e079c6cc3d134167857f7269189072cb814630e6d43813a0f8744436e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7aa690ac45ef052ba0b4d7d46b99349927bcbee98271afee4b0bdd819fd1eecb"
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
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
