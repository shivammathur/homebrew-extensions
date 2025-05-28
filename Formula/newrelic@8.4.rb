# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v11.9.0.23.tar.gz"
  sha256 "2a1481794a580dcd19a00ccd6b82ff56e1fd2acc31dae8d0306d2990afe5fe8e"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e66434af7c77c1bc1fc2a2feee81867972b61a429e899505d46e239839933b0f"
    sha256 cellar: :any,                 arm64_sonoma:  "51e5c49eeb9fa4c830affc7ace87d674077d41965242d8a6a64b7b46568d190d"
    sha256 cellar: :any,                 arm64_ventura: "677b9f6cef95132130292ba802fdbbecf5c9692eb267ad31d0081d758c213213"
    sha256 cellar: :any,                 ventura:       "aad69af138ad63467fd947b5a36d01d1808e7606f812a6a8066c404934fc9518"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "94143c42e33fecf476267fbd3bf736c12e38dd51b3b6a5203516fd332fff1967"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "416255083ec82f3a761dc870d2080723d846b2f64f56f55ab1b0f6b2898ed344"
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
    system "make", "daemon"
    system "make", "agent"
    prefix.install "agent/modules/#{extension}.so"
    prefix.install "bin/daemon"
    write_config_file
  end
end
