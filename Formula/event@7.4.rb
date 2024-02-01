# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT74 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "499dda5a1de1f800f44afc799d190320b237c21f86621b0069c2db9df33e85c2"
    sha256 cellar: :any,                 arm64_ventura:  "9de4668d2c66a30d4ea9c53e7b0a1c28508163e8de641763775a42ecb94cd8d9"
    sha256 cellar: :any,                 arm64_monterey: "7eb30e754312e7588ba24acf2ed171b9a476de5b7af2a3a373716824b6d1ca59"
    sha256 cellar: :any,                 ventura:        "85ab79067079219f6e740364fbac18f5d3550b9dc447606810df0df05353a19c"
    sha256 cellar: :any,                 monterey:       "166d5d80362ebd54131dcad94ac3aa4085494f23b0797c1f3e9895416a722cbb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c4a05c586857abc85faa36b342e203f201234b0da1a88477d67e26f06298ca7b"
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
