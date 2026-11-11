# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT87 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.2.0.tgz"
  sha256 "fb3d4e3c9fdc79125274f2b46461492923edec6b489ed7077973f7e65f41dc1c"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "13298ea95d7d8c8b235193794c809f44eaba844806e0eb36426830e060858f7d"
    sha256 cellar: :any, arm64_tahoe:       "d1941c35f1cf8b20d105d6e56f55864f0eca9bfed67c66563fd13dcc96243df5"
    sha256 cellar: :any, arm64_sequoia:     "1b863fe5e324441b334b7ddb24bb7954234f1a97adb230244fbea7eabce06b8d"
    sha256 cellar: :any, arm64_linux:       "44022d54177b54e69a3cd416a81717d0d92a15312be4145ffee948d92fa985ce"
    sha256 cellar: :any, x86_64_linux:      "269c634b923f83be557125319475421858280aa845cad166824c641ff843d8c2"
  end

  depends_on "libevent"
  depends_on "openssl@4"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
      --with-event-libevent-dir=#{Utils::Path.formula_opt_prefix("libevent")}
    ]
    Dir.chdir "event-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
