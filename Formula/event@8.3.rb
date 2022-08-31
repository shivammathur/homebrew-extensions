# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT83 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.0.8.tgz"
  sha256 "e3e91edd3dc15e0969b9254cc3626ae07825e39bf26d61b49935f66f603d7b6b"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "833f9d033c12ccb95eb5867cb009323f6f5d943e2592090297d03618fd593af0"
    sha256 cellar: :any,                 arm64_big_sur:  "2e41c1305aa5c4f356948248c3d5ff20fcd366b4c1db9903e1747bf5f904bbf2"
    sha256 cellar: :any,                 monterey:       "0cc8fe613b168edcdb87b8eea9f638d3fd0fc65651b3a4baf0104fea5c05d3ed"
    sha256 cellar: :any,                 big_sur:        "0705c00ca0d856491d4785c5881a71ceb1d53004b9a613d719acfae40f6adac9"
    sha256 cellar: :any,                 catalina:       "fff79f054281dec248da1fe993e7430baca2ec6ec063fb2dcf3c46c9aedb60e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3149bad059c8f80714a81a60504ad26c57a5b7611d57fa549e4cd03723ad6a78"
  end

  depends_on "libevent"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
