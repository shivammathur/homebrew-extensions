# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Newrelic Extension
class NewrelicAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sonoma:   "9c94a00e5b360e93591bbaa540ff9e20a044d6044e977ac06ae7fe1f2a1164cb"
    sha256 cellar: :any,                 arm64_ventura:  "925bd33eb7d9a9af666300cf02eb5a87cfd512e0753d293b520510ef18364505"
    sha256 cellar: :any,                 arm64_monterey: "aa9c1d706b5473ddb5c56cfa301f38baade0a2bf5e0892fa45abfeef5cdea0a0"
    sha256 cellar: :any,                 ventura:        "511fabf26decc58594be013f1a15176cb345870cd6cffa41550f32b3cf0d9c45"
    sha256 cellar: :any,                 monterey:       "7373e491fb8ccc7e42a329b5d3c2c1bf0ad94999a832de813bfa047a83f0f588"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a0558afad4cf82689873f5fc5841eb7a1bd2faaa5996502792f568a826aa5cff"
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
