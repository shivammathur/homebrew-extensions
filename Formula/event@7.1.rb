# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT71 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "de204ab844b71833883a08714537b859189b073265d9b8b246a0f4071925d6db"
    sha256 cellar: :any,                 arm64_ventura:  "3af51aa8823945904dc498da7c7100d818293015b307133fec30638b3af2db98"
    sha256 cellar: :any,                 arm64_monterey: "8d70c73a9ef2a49bc78c3e5e09702366c2a5d17929a232ee1a4ae90d0de2fff6"
    sha256 cellar: :any,                 ventura:        "db11f1d2980d62f0461b1abbceba1dc26164c61488a0615c144f4ead79620aba"
    sha256 cellar: :any,                 monterey:       "23bf0a33bd9f654ac8b9b0f8c1d84024ee5ea4f7415fba2c7ff5f84a332b386c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b9267ca1b2a3a77fb6569a10500844f610b49a82e63c4d60a89ab5e071719e32"
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
