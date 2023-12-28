# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT80 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.0.tgz"
  sha256 "3e0e811c54a64b7c6871fbd4557cc3f03bfd31a53f9504b479102c767a23ce41"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "7661fc467aca649fa9a6361a8dc11ff1d802dcc5c9f7e16a9fcb7edb66c7111f"
    sha256 cellar: :any,                 arm64_monterey: "838e88295cbb0bf34c61fc87efa2e925afcb2a50455540aa77e102b58b0ff9f1"
    sha256 cellar: :any,                 arm64_big_sur:  "b3749518e3fd6460e960bbd00e8d0ee71d67298dd9162a09bd670b63b92659a0"
    sha256 cellar: :any,                 ventura:        "b5312337ff6cb2b686aaaffadaeb57209224fb46cfc8156a9099ce6dfa74f855"
    sha256 cellar: :any,                 monterey:       "5e97b9fb73690f51e1ead4e94879756c3e029c0195953cca541eb551cbb16447"
    sha256 cellar: :any,                 big_sur:        "3a5a4a36d3ed50879059bc77b4187199585b79e07ba264ac5dc720ac343f2528"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e140837224e4c118ec8b28c6bf54ed99829e3738e854b147783f35df0ad607c1"
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
