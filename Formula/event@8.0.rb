# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT80 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.6.tgz"
  sha256 "5b74554c6370aae8c284c8110fe27e071d3f663953c3eb762ffc429b0a3c83a2"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "d9701b52c641796a51cad9b448c206500c8824dc6d94d32c90f6fa531fa48d6b"
    sha256 cellar: :any, arm64_tahoe:       "18b99cbade8c700caf2cdeccea3d90c21ec822e12d9d5e5e47247a6763831cc7"
    sha256 cellar: :any, arm64_sequoia:     "290d37506f90ff674f2d3dd1b24cbd2c347ec02bcaef9d0164ead07d2b1f408f"
    sha256 cellar: :any, arm64_linux:       "23111fecb1bd162e9d7a3121452c9939cd886c0abdd9f6eea7ace09635302d1c"
    sha256 cellar: :any, x86_64_linux:      "aa86c66f3b29c6d9f294ebe620d65e4bd3d518ab8c130ca02843574a7e643234"
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
