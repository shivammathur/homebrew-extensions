# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT71 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.0.tgz"
  sha256 "3e0e811c54a64b7c6871fbd4557cc3f03bfd31a53f9504b479102c767a23ce41"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "1c15479343570d18cdeced8edce81cae483a7c7a6fdc4314747ce6e3e5d66ff9"
    sha256 cellar: :any,                 arm64_ventura:  "4b85c1efddd2e3ad75fb395662f9c6f630151baab1058f6b54cdbbaebf463998"
    sha256 cellar: :any,                 arm64_monterey: "08ea4380d9b2705568c61ed6751ee94920f14c48a4244d13efe0dc3cdedbc4ce"
    sha256 cellar: :any,                 ventura:        "d6a8c37b015db15d92a46d257b3d1f05503ab90e1e913b6f95b11d8e8c308834"
    sha256 cellar: :any,                 monterey:       "77bf07ba3bec923af8ddb55a9ccbb8d956648d0ceee8a820813ed4b7560dea7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "38048d8b5eab0d4e82162924fdbe51f53ec686f4f1cb3d159079fd3d78c44ac7"
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
