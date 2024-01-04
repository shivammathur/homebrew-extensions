# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT80 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.1.tgz"
  sha256 "d028f0654f83e842cb54a7530942363a526fb0da439771c7a052de6821c381ea"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "44a6e51a6988ecdb0826e69832ebd702c9c20116aad514a47ce2aa8b75db063e"
    sha256 cellar: :any,                 arm64_ventura:  "6a1d7a8d26918b56f3459c131833144a62e90fc8b570cb4a3c8ff5a88ce45465"
    sha256 cellar: :any,                 arm64_monterey: "2fa48cb5c907ace2f39138bbbafbb354a15bed74fb1b9abe7b2a227b259a61bf"
    sha256 cellar: :any,                 ventura:        "f5d155921faa939dfff8f57917c8e01b124b686c94c4bf0c7b84c1fb52bd7163"
    sha256 cellar: :any,                 monterey:       "cee50d64852c1bb68d04ab2b3912268254a5464c2d795a332266efe895344b41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b9246ba3a2976d8714e666276887f5767d05df680fd74d806c522ecc2090268d"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-event-libevent-dir=#{Formula["libevent"].opt_prefix}
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
