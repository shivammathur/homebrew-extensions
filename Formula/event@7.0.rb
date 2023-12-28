# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT70 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.0.tgz"
  sha256 "3e0e811c54a64b7c6871fbd4557cc3f03bfd31a53f9504b479102c767a23ce41"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "5bf47e8504c2b77d6f9e811bc1ed60d7cfe7c7be053eed829da0434d81cc9a61"
    sha256 cellar: :any,                 arm64_monterey: "eb1e4a117408778a9066716e3869a456cd6ca88c6cd2d2f7b55693a4f8dd6da6"
    sha256 cellar: :any,                 arm64_big_sur:  "e043f6a23284eceb5687868ade4478877b67320e4b835972c1b992536ac9be46"
    sha256 cellar: :any,                 ventura:        "ec79c0c4a5b023920826253e224d2096a446a7920f8ffcf18b3f57690a134b30"
    sha256 cellar: :any,                 monterey:       "d9dafa5670a91f33bdde8717806008a4da744d1730300fc2f7d6304f68d5f4c3"
    sha256 cellar: :any,                 big_sur:        "abb3fff97eea05eab223ea772f31b4800371e55e6c2698dba7fbc15f6e805af7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b65bd170a5d4972e56bdaaa7e19a6be9bf715ca6cd8a9c65b67fdeede35df8d6"
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
