# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT82 < AbstractPhpExtension
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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "70aa3d8bdf41f33a204b96b341b99612ef63432125aa70c8f5bcf6bde640f026"
    sha256 cellar: :any,                 arm64_big_sur:  "f74f407438070678df2224a8ad4ec4a303878033bbcf7aee2eb480f31810391e"
    sha256 cellar: :any,                 ventura:        "785b4aedc5359c5109186e6c12a3e3b76e164ebe61c3dfd41a83514cebfea191"
    sha256 cellar: :any,                 monterey:       "6c45f086163df13b4cf586fe676c10761b72c930617529fd1a20d1b88fd7ca92"
    sha256 cellar: :any,                 big_sur:        "464d84f2c0b50f1094f0bdba36fe967aa0d710bf40728f24359bb5b964554f0d"
    sha256 cellar: :any,                 catalina:       "b6bd72bc7d9c8620c0fe6405750e23bdc195dc776c03df18ba935d63418d7a91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bf9c1186b591cc1d9ed3063c0b5371a7c86424cb79a91673668ca9f0eaf3de9a"
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
