# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT82 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.1.tgz"
  sha256 "d028f0654f83e842cb54a7530942363a526fb0da439771c7a052de6821c381ea"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "7940b8310916d11e039a7c3a0d65852a788d18f1454a8796b1d1428f871286b2"
    sha256 cellar: :any,                 arm64_ventura:  "719a3d88df86ab2c19a4a31e151bd88f5a043e797a4bafcff58353d993893936"
    sha256 cellar: :any,                 arm64_monterey: "108da9958265e20eec38928d448e8bb9b4257243db71538bd3cfb56f0f903c4e"
    sha256 cellar: :any,                 ventura:        "3d12afc7a9fa80422c4838b0682960e1bb49e5bff9c7de2aaead47753451671f"
    sha256 cellar: :any,                 monterey:       "9072bc8f0020813799030121a59e4d6486d3bb71217c3cf8c1d6cc9e43cdcb51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b42032c4761f7545c2ee7a3775c1f35581334e1f4de1579fd7001bb65d02fc36"
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
