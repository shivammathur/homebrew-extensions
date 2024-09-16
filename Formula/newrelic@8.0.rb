# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT80 < AbstractPhpExtension
  init
  desc "Newrelic PHP extension"
  homepage "https://github.com/newrelic/newrelic-php-agent"
  url "https://github.com/newrelic/newrelic-php-agent/archive/refs/tags/v11.0.0.13.tar.gz"
  version "v11.0.0.13"
  sha256 "69f72541acf03e63a4d7d4a1053857b009279d1c526c9b68ed1338670a9e2cc0"
  head "https://github.com/newrelic/newrelic-php-agent.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "c323eeb2f763a80d098a83699088db2f7043ecac16514f2be05e2edd5c38f681"
    sha256 cellar: :any,                 arm64_sonoma:   "3d42e9c22e68038c4983c5c0fb91c8ad32c6047772d34b06e1a9fec01b2626d5"
    sha256 cellar: :any,                 arm64_ventura:  "747ac426f06410c42ddd428872fd20ff714cbd5dd968a33175227d865c9e72b7"
    sha256 cellar: :any,                 arm64_monterey: "81cc33b4c09e6e95bb9466fc7ac58ce684031488db67b5a68234d7051d5d1d68"
    sha256 cellar: :any,                 ventura:        "3f18d74049cc3f1cd1fcb8bce765b616c06d1dd21de8a653ca2dcd5e3fb68cb6"
    sha256 cellar: :any,                 monterey:       "769e6ea88361856deaebcdd3794e790862359701e55f1787a5a367f2c1709e1a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d03ac34aeda5e077cce7f63767e26b4e1664aabe147b1e7a247896dd2616de01"
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
