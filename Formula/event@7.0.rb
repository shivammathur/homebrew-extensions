# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT70 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.4.tgz"
  sha256 "5c4caa73bc2dceee31092ff9192139df28e9a80f1147ade0dfe869db2e4ddfd3"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "4853b7b8692f8a3db7602413c71ade69e39b2bfe754ff5ad1a67263445a00ba6"
    sha256 cellar: :any,                 arm64_ventura:  "fb45629d21b9d09a69cf55c2b87b27ef528433d019997558e7c3ff5f8303d100"
    sha256 cellar: :any,                 arm64_monterey: "2d3837169dbb05a5874d7c34ad021b48d03fd2587f6c4cf5612c5a635340e9e6"
    sha256 cellar: :any,                 ventura:        "61b15bd029f1c8bd8d0c8f139ecc7d81ae723f8acefa6e142e66ce387eec9124"
    sha256 cellar: :any,                 monterey:       "0a6e31c758b7328ea72f59716aef743b7d2d519b8337a7b15db3d7f56bd91cac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a2ae625e229cc63cfa9f45ca8fee7b9193d63cd28132b9bcaaed525851b91f6e"
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
