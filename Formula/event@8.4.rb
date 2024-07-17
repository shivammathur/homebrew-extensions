# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT84 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.4.tgz"
  sha256 "5c4caa73bc2dceee31092ff9192139df28e9a80f1147ade0dfe869db2e4ddfd3"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "ea49fe2be4500fc753b0e4413b5305e325954389cc02796cbbe0b710155e6564"
    sha256 cellar: :any,                 arm64_ventura:  "d23c0797cf2a993e877c49e1e68c820e7b64e52f156417282f234b5b08522461"
    sha256 cellar: :any,                 arm64_monterey: "503c8098dcb21f24e294af22add061fe306ac581bad8018ac6304bff047bb359"
    sha256 cellar: :any,                 ventura:        "161e7afc019e0391167060f226a4b4a22afd861824993ee6672679d9fa3ee518"
    sha256 cellar: :any,                 monterey:       "3c76378b1236cc1f4cee07a7f019b0f3b10f68e11890e2371779c5da1e982a43"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "da5cb0b09d137c556d0273c4736c9d57d2343cdcd1336cca5609bf010e32efb1"
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
