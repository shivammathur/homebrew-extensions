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
  revision 2
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "8968c19423058dc61c95c94bcb7a47808371630330e8bf88738773345f326163"
    sha256 cellar: :any, arm64_tahoe:       "25258d7d5a0baf02fa266f043c6f507d8c49b31e3bbdb64d3ef33c51a4610bcb"
    sha256 cellar: :any, arm64_sequoia:     "fd46f83f9846a89c2c5dcf0392bb4fe71fc8ee6a879c1446c4b251816530e877"
    sha256 cellar: :any, arm64_linux:       "af70b4908f1b357a1bfa4cac3c2bce5da555b6968e6a357eb9fa6db7246df287"
    sha256 cellar: :any, x86_64_linux:      "1082697761ea302c7f5e381918a9ddf236cfce47642c972cfe83f663b660cadc"
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
