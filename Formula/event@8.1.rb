# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT81 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "0bf1cd1d3a2b38d5c08235de30b72c74830f663ae9f23c4b42b9067fce4042fb"
    sha256 cellar: :any,                 arm64_ventura:  "343560127db07003cd84c483bc444bb449b7615c1dbf6d7bb128443eb5df0bac"
    sha256 cellar: :any,                 arm64_monterey: "560ca1fe7b937fb8407c6e7772e9c95c0358f7275ee7afb41e65c22a4df80efb"
    sha256 cellar: :any,                 ventura:        "ebe125e83472d3c6ac6743b542850ed42403896a452514ac0d59ac32ca26f7d9"
    sha256 cellar: :any,                 monterey:       "7a9c43303829162a68606850d1ce4f24f09ba086bc296976ac4d4d7bd4eb2458"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c534b4f1a92c2fc8bcba40cb750231a55b75e5fcae1acb1708897a68c2660caf"
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
