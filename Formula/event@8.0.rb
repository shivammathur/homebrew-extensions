# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT80 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.0.8.tgz"
  sha256 "e3e91edd3dc15e0969b9254cc3626ae07825e39bf26d61b49935f66f603d7b6b"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "978c4f4ed6431113860b3661ff25807c17e2e6499e1eebad6069b229f7a18501"
    sha256 cellar: :any,                 arm64_big_sur:  "ee8cee160bc4c47a7aab444f507a98760c0b14eda150f70c202bf6d6c39dd58e"
    sha256 cellar: :any,                 ventura:        "9bbaaeb3ad0e2923faa6d0c62b739b5927906242f6b0b9c8e7caaf8b6bb036b9"
    sha256 cellar: :any,                 monterey:       "63330054f53c7e62878cc1dff20858ce5e2baad96f55d88013c5b72d95f05485"
    sha256 cellar: :any,                 big_sur:        "85e5876c1973f740fcbf26b568e8c1e0105b1edd290c93adcc0eb5fc097cacc4"
    sha256 cellar: :any,                 catalina:       "542dfdee284ac99a5121b5349a38768c31f8bd100f59c0e4d396851518a205b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f17ac172a7c87f92bb4e74b1072f4504aa41e29a017c0c79e571e5d1c08f1fe0"
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
