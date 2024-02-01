# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT81 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "b263731d455ace1d9b86ab0560524cf641910419426481cddba4eb7a31e3d3ec"
    sha256 cellar: :any,                 arm64_ventura:  "de600d2e8e34c51984dd2c7507d09acb092947c4f1bcc3c829a42c77df55fe93"
    sha256 cellar: :any,                 arm64_monterey: "cabf2a182dc4d4e7aa88478539b0c531e17e7674d001cf05b3d8280ee379bf66"
    sha256 cellar: :any,                 ventura:        "9910aa6781d2e37a0b75af2d27a7b7ca94e2126f17f96d1a62d15f15a0db7b23"
    sha256 cellar: :any,                 monterey:       "a96c1c3a18a56f1e4e8e930e7526abd0c3b410b81190f16bd4f10919c7a95dd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bc4602471710385ba9cf8780ed8c6f2061c33584192972561428bc7228fd5c40"
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
