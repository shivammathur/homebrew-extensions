# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT80 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "72754a3560202dfd39f6566ba11ecd78218cd4bb15a14768e894c475495d9e51"
    sha256 cellar: :any,                 arm64_ventura:  "b52a0c1e903135d52984f6608eafb291ef960f68716ec2fd76e90b6b426f861b"
    sha256 cellar: :any,                 arm64_monterey: "60ce6229417332fab5300a791d814dfe3a3c4d39b3feaff51484f1d324bc7c3c"
    sha256 cellar: :any,                 ventura:        "b3dbfb86704bc84d4279439635896633933440c2ab134fecc8cbacbbd4461bf9"
    sha256 cellar: :any,                 monterey:       "28829b78bafa6f4884a21bb6a5f70bbefaf62759c36b2e0950199bca5b830ee1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "88ad7c69e21d98accc2aef45fa28320d0af78ce3e9717ba5d524a54396804c9f"
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
