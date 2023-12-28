# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT82 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.0.tgz"
  sha256 "3e0e811c54a64b7c6871fbd4557cc3f03bfd31a53f9504b479102c767a23ce41"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "c2816c9d8bfa1adb53eabec23bb834a941bf68e5207c390db6afb7ac1304e251"
    sha256 cellar: :any,                 arm64_ventura:  "51c8cd21afe2203caef4417ca0827139c5e8239b142007009053db3da68729dc"
    sha256 cellar: :any,                 arm64_monterey: "b36de4261df0ae4837c741d51f8a0242fc5b6e7a5d31cce321707cb1467ee453"
    sha256 cellar: :any,                 ventura:        "c241f19c6dedc9758d49f1f9b70eb7be18874a49755eec599c71debe182813ed"
    sha256 cellar: :any,                 monterey:       "c491dd27537e1ae6ff3fa87d5bb7198d22ac7f5f976c7112d64e90d51cc49cf1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1bcf582f98e7fc23ff977a11970b7967e53e82a90d6d85c658d8c3d4531954b2"
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
