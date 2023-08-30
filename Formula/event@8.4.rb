# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT84 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.0.8.tgz"
  sha256 "e3e91edd3dc15e0969b9254cc3626ae07825e39bf26d61b49935f66f603d7b6b"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "9666e845b6deeb6a49bb29c58afeeac76e3d3adfd628aaeffb687644db93671b"
    sha256 cellar: :any,                 arm64_big_sur:  "a971939b839813b3687ce869728a4115dfde9df2859368001266a659691f2425"
    sha256 cellar: :any,                 ventura:        "77302c12ba6e362eb8c5ced10e06bc94dc6a538adae4837647ef397ab4bd0012"
    sha256 cellar: :any,                 monterey:       "e9f3731eb7fb9123b2443ba83c9f93cab5b02d70e896b5d07b4ff962353af5f1"
    sha256 cellar: :any,                 big_sur:        "3822f8dace2d5bdca5f11ea728be63168ffaf4356f5f9c068530048969b76335"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ca80f37ce1ac3353178e8094ec9a5f7dce37525bbec1304e4e11fe7cf3d75ef8"
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
