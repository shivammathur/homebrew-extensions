# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT70 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.1.tgz"
  sha256 "d028f0654f83e842cb54a7530942363a526fb0da439771c7a052de6821c381ea"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "f7ebf6b9c45b836a456fba26a06f690064187f2f030b72335bfb0d3f828ac6f6"
    sha256 cellar: :any,                 arm64_ventura:  "750a249eb904da4af0b19533e61c907f9f4a8c20697fdbc3e6299a2026b0edbd"
    sha256 cellar: :any,                 arm64_monterey: "280c48e714fd92bde0cb49859fc13097b395e11a9ca89d0f524be97759b12035"
    sha256 cellar: :any,                 ventura:        "e406fc53bab5b4509ce000604406d2734cfb91601a44f4a99fcab2cf748e3775"
    sha256 cellar: :any,                 monterey:       "8b4c9c9f3110647d67d9de40a4a85d1563f6474756639e91eb8a6ec0619bf53f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d29fd185383fb30eb1912af147b80e79ab9f10d3c4b5e3316ab3262baa979ca4"
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
